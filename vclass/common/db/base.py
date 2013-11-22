"""Database session, engine and the base class for model classes"""

from uuid import uuid1

from sqlalchemy import create_engine, MetaData
from sqlalchemy.orm import scoped_session, mapper as sqla_mapper, create_session
from sqlalchemy.ext.declarative import declarative_base, _declarative_constructor

__all__ = ['metadata', 'session', 'Base', 'new_guid']

def _create_session():
    return create_session(bind = engine, autoflush = False)

engine = None
session = scoped_session(_create_session)
metadata = MetaData()


def _create_engine():
    """Setup database from current configuration"""
    global engine
    if engine is None:
        metadata.bind = engine = engine_from_config_settings('sqlalchemy')


def _destroy_engine():
    """Setup database from current configuration"""
    global engine
    if engine is not None:
        # Nuke connection state
        engine.dispose()
        # Nuke ORM state
        session.remove()
        engine = None


def recreate_engine():
    _destroy_engine()
    _create_engine()


def engine_from_config_settings(config_name):
    pass


_create_engine()


class Base(object):
    """Base class for ORM objects"""

    @classmethod
    def get(cls, key):
        pass
    
    def __unicode__(self):
        namestr = ''
        if hasattr(self, 'name') and self.name:
            namestr = ' ' + self.name
        return u'<%s(%s)%s>' % (self.__class__.__name__, self.id, namestr)

    def __str__(self):
        return unicode(self).encode('utf-8')

    def __repr__(self):
        return str(self)

    @classmethod
    def like(cls, name):
        pass
    @classmethod
    def all_like(cls, name):
        pass
    
    @classmethod
    def by_name(cls, name):
        pass
    
    
def mapper(cls, *arg, **kw):
    pass

Base = declarative_base(cls = Base, constructor = Base.__init__,
                        metadata = metadata, mapper = mapper)

def new_guid():
    return str(uuid1())