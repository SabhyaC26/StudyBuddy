from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

student_association_table = db.Table(
    'students',
    db.Model.metadata,
    db.Column('student_id', db.Integer, db.ForeignKey('student.id')),
    db.Column('class_id', db.Integer, db.ForeignKey('class.id'))
)


class Student(db.Model):

    __tablename__ = 'student'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    netid = db.Column(db.String, nullable=False)
    classes = db.relationship('Class', secondary=student_association_table)

    def __init__(self, *args, **kwargs):
        self.name = kwargs.get('name', '')
        self.netid = kwargs.get('netid', '')

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'netid': self.netid,
            'classes': [c.serialize() for c in self.classes]
        }


class Class(db.Model):

    __tablename__ = 'class'
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String, nullable=False)
    name = db.Column(db.String, nullable=False)

    posts = db.relationship('Post', cascade='delete')

    def __init__(self, *args, **kwargs):
        self.code = kwargs.get('code', '')
        self.name = kwargs.get('name', '')

    def serialize(self):
        return {
            'id': self.id,
            'code': self.code,
            'name': self.name,
            'posts': [p.serialize() for p in self.posts],
            'students': [s.serialize() for s in self.students]
        }


class Post(db.Model):

    __tablename__ = 'post'
    id = db.Column(db.Integer, primary_key=True)
    text = db.Column(db.String, nullable=False)
    student_id = db.Column(db.Integer, db.ForeignKey(
        'student.id'), nullable=False)
    class_id = db.Column(db.Integer, db.ForeignKey('class.id'), nullable=False)

    def __init__(self, *args, **kwargs):
        self.text = kwargs.get('text', '')
        self.class_id = kwargs.get('post_id', '')
        self.student_id = kwargs.get('student_id', '')

    def serialize(self):
        return {
            'id': self.id,
            'text': self.text,
            'class_id': self.class_id,
            'student_id': self.student_id
        }
