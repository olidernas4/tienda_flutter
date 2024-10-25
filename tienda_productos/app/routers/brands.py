from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app import crud, schemas
from app.database import SessionLocal

router = APIRouter()

# Dependencia para obtener la sesión de la base de datos
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/brands/", response_model=schemas.Brand)
def create_brand(brand: schemas.BrandCreate, db: Session = Depends(get_db)):
    return crud.create_brand(db=db, brand=brand)

@router.get("/brands/", response_model=list[schemas.Brand])
def read_brands(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    brands = crud.get_brands(db=db, skip=skip, limit=limit)
    return brands
