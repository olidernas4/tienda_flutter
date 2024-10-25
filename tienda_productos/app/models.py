from sqlalchemy import Column, Integer, String, Float, ForeignKey, CheckConstraint
from sqlalchemy.orm import relationship
from app.database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True)
    password = Column(String)

class Category(Base):
    __tablename__ = "categories"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)

class Brand(Base):
    __tablename__ = "brands"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)

class Product(Base):
    __tablename__ = "products"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    description = Column(String, index=True)  # Puedes cambiar a Text si es necesario
    brand_id = Column(Integer, ForeignKey('brands.id'))
    category_id = Column(Integer, ForeignKey('categories.id'))
    price = Column(Float)
    rating = Column(Float, CheckConstraint('rating <= 5.0', name='check_rating_max_5'))  # Restringe el valor máximo de rating a 5.0

    brand = relationship("Brand", back_populates="products")
    category = relationship("Category", back_populates="products")

# Relaciones entre Product, Brand y Category
Brand.products = relationship("Product", order_by=Product.id, back_populates="brand")
Category.products = relationship("Product", order_by=Product.id, back_populates="category")
