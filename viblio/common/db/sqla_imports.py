from sqlalchemy import (
    Table, Column, ForeignKey, DefaultClause,
    BLOB, CHAR, String, Unicode, Enum, Boolean, Integer, Float, DATE, Date, DateTime,
)

from sqlalchemy.dialects.mysql import (
    INTEGER as MSInteger, BIGINT as BigInteger, TIMESTAMP as Timestamp,
    TEXT as Text, VARCHAR,
)
from sqlalchemy.sql import (
    func, literal, cast, or_, and_, not_, select, join, outerjoin, alias
)
from sqlalchemy.schema import FetchedValue, UniqueConstraint
from sqlalchemy.orm import relation, backref, synonym, aliased, eagerload
from sqlalchemy.ext.associationproxy import association_proxy
from sqlalchemy.ext.declarative import declarative_base, synonym_for, declared_attr
from sqlalchemy.exc import IntegrityError

UnicodeText = Text(charset = 'utf8', convert_unicode = True)

def Unicode(length):
    return VARCHAR(length, charset = 'utf8', convert_unicode = True)

URL = VARCHAR(4096, charset = 'ascii', collation = 'ascii_bin')