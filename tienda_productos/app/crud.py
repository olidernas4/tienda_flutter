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

# Rutas para productos
@router.post("/products/", response_model=schemas.Product)
def create_product(product: schemas.ProductCreate, db: Session = Depends(get_db)):
    return crud.create_product(db=db, product=product)

@router.get("/products/", response_model=list[schemas.Product])
def read_products(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    return crud.get_products(db=db, skip=skip, limit=limit)

@router.put("/products/{product_id}", response_model=schemas.Product)
def update_product(product_id: int, product: schemas.ProductCreate, db: Session = Depends(get_db)):
    return crud.update_product(db=db, product_id=product_id, product=product)

@router.delete("/products/{product_id}", response_model=schemas.Product)
def delete_product(product_id: int, db: Session = Depends(get_db)):
    return crud.delete_product(db=db, product_id=product_id)

# Rutas para categorías
@router.post("/categories/", response_model=schemas.Category)
def create_category(category: schemas.CategoryCreate, db: Session = Depends(get_db)):
    return crud.create_category(db=db, category=category)

@router.get("/categories/", response_model=list[schemas.Category])
def read_categories(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    return crud.get_categories(db=db, skip=skip, limit=limit)

@router.put("/categories/{category_id}", response_model=schemas.Category)
def update_category(category_id: int, category: schemas.CategoryCreate, db: Session = Depends(get_db)):
    return crud.update_category(db=db, category_id=category_id, category=category)

@router.delete("/categories/{category_id}", response_model=schemas.Category)
def delete_category(category_id: int, db: Session = Depends(get_db)):
    return crud.delete_category(db=db, category_id=category_id)

# Rutas para marcas
@router.post("/brands/", response_model=schemas.Brand)
def create_brand(brand: schemas.BrandCreate, db: Session = Depends(get_db)):
    return crud.create_brand(db=db, brand=brand)

@router.get("/brands/", response_model=list[schemas.Brand])
def read_brands(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    return crud.get_brands(db=db, skip=skip, limit=limit)

@router.put("/brands/{brand_id}", response_model=schemas.Brand)
def update_brand(brand_id: int, brand: schemas.BrandCreate, db: Session = Depends(get_db)):
    return crud.update_brand(db=db, brand_id=brand_id, brand=brand)

@router.delete("/brands/{brand_id}", response_model=schemas.Brand)
def delete_brand(brand_id: int, db: Session = Depends(get_db)):
    return crud.delete_brand(db=db, brand_id=brand_id)
