import os
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

class Config:
    DATABASE_URI = os.getenv('DATABASE_URI', 'postgresql://olider:esuvejes1@localhost/producto')

# Crea el motor de la base de datos utilizando la URI de la configuración
engine = create_engine(Config.DATABASE_URI)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base declarativa para los modelos
Base = declarative_base()
