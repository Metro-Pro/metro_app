from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from db.database import get_db
from db.models import User
from core.security import decode_token

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/")


def get_current_user(
    token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)
) -> User:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )

    payload = decode_token(token)
    if not payload or "sub" not in payload:
        raise credentials_exception

    user = db.query(User).filter(User.id == payload["sub"]).first()
    if not user:
        raise credentials_exception

    return user


# Additional fix for utils/permissions.py to ensure admin checking works
def get_admin_user(current_user: User = Depends(get_current_user)):
    """Dependency to ensure current user is an admin"""
    if not hasattr(current_user, "is_admin") or not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Admin access required")
    return current_user
