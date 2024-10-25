from pydantic import BaseModel
from typing import List, Optional

# Esquemas de Producto
class ProductBase(BaseModel):
    name: str
    description: str
    brand_id: int
    category_id: int
    price: float
    rating: Optional[float] = None

class ProductCreate(ProductBase):
    pass

class Product(ProductBase):
    id: int

    class Config:
        from_attributes = True  # Habilita el modo ORM para permitir la conversión de modelos SQLAlchemy a Pydantic

# Esquemas de Categoría
class CategoryBase(BaseModel):
    name: str

class CategoryCreate(CategoryBase):
    pass

class Category(CategoryBase):
    id: int
    products: List[Product] = []  # Relación con productos

    class Config:
        from_attributes = True

# Esquemas de Marca
class BrandBase(BaseModel):
    name: str

class BrandCreate(BrandBase):
    pass

class Brand(BrandBase):
    id: int
    products: List[Product] = []  # Relación con productos

    class Config:
        from_attributes = True

# Esquemas de Usuario
class UserCreate(BaseModel):
    email: str
    password: str

class User(UserCreate):  # Hereda de UserCreate para evitar duplicación
    id: int

    class Config:
        from_attributes = True

# Esquema para devolver el token
class Token(BaseModel):
    access_token: str
    token_type: str

# Esquema para respuesta de usuario con token
class UserResponse(User):
    token: Token

    class Config:
        from_attributes = True
