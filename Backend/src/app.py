
[]'import json
from flask import Flask, request
from db import db, Student, Class, Post

app = Flask(__name__)
db_filename = 'main.db'

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

db.init_app(app)
with app.app_context():
    db.create_all()


@app.route('/')
def root():
    return json.dumps({'success': True, 'data': 'Welcome to HW Help'}), 201


@app.route('/api/classes/')
def get_classes():
    classes = Class.query.all()
    res = {
        'success': True,
        'data': [c.serialize() for c in classes]
    }
    return json.dumps(res), 200


@app.route('/api/classes/', methods=['POST'])
def create_class():
    post_body = json.loads(request.data)
    code = post_body.get('code')
    name = post_body.get('name')
    if code is None or name is None:
        return json.dumps({'success': False, 'error':
                           'class code or name is missing'}), 200
    new_class = Class(
        code=code,
        name=name
    )
    return json.dumps({'success': True, 'data': new_class.serialize()}), 201


@app.route('/api/class/<int:class_id>/', methods=['POST'])
def get_class(class_id):
    opt_class = Class.query.filter_by(id=class_id).first()
    if opt_class is not None:
        return json.dumps({'success': True, 'data': opt_class.serialize()}), 200
    return json.dumps({'success': False, 'error': 'Class not found'}), 404


@app.route('/api/class/<int:class_id>/', methods=['DELETE'])
def delete_class(class_id):
    opt_class = Class.query.filter_by(id=class_id).first()
    if opt_class is not None:
        db.session.delete(opt_class)
        db.session.commit()
        return json.dumps({'success': True, 'data': opt_class.serialize()}), 200
    return json.dumps({'success': False, 'error': 'Class not found'}), 404


@app.route('/api/student/', methods=['POST'])
def create_student():
    post_body = json.loads(request.data)
    new_user = Student(
        name=post_body.get('name'),
        netid=post_body.get('netid'),
    )
    db.session.add(new_user)
    db.session.commit()
    return json.dumps({'success': True, 'data': new_user.serialize()}), 201


@app.route('/api/student/<int:student_id>/')
def get_student(student_id):
    opt_student = Class.query.filter_by(id=student_id).first()
    if opt_student is not None:
        return json.dumps({'success': True, 'data': opt_student.serialize()}), 200
    return json.dumps({'success': False, 'data': 'User not found'}), 200


@app.route('/api/student/<int:student_id>/', methods=['DELETE'])
def delete_student(student_id):
    pass


@app.route('/api/student/<int:class_id>/add/', methods=['POST'])
def add_student_to_class(class_id):
    post_body = json.loads(request.data)
    student_id = post_body.get('student_id', '')

    if student_id is None:
        return json.dumps({'success': False,
                           'error': 'student id is missing'})

    opt_student = Student.query.filter_by(id=student_id).first()
    opt_class = Class.query.filter_by(id=class_id).first()

    if opt_student is None or opt_class is None:
        return json.dumps({'success': False,
                           'error': 'Class or User not found'}), 404

    opt_class.students.append(opt_student)

    db.session.add(opt_class)
    db.session.commit()

    return json.dumps({'success': True,
                       'data': opt_class.serialize()}), 200


@app.route('/api/student/<int:class_id>/add/', methods=['DELETE'])
def remove_student_from_class(class_id):
    post_body = json.loads(request.data)
    student_id = post_body.get('student_id', '')

    if student_id is None:
        return json.dumps({'success': False,
                           'error': 'student id is missing'})

    opt_student = Student.query.filter_by(id=student_id).first()
    opt_class = Class.query.filter_by(id=class_id).first()

    if opt_student is None or opt_class is None:
        return json.dumps({'success': False,
                           'error': 'Class or User not found'}), 404

    opt_class.students.remove(opt_student)
    db.session.add(opt_class)
    db.session.commit()

    return json.dumps({'success': True,
                       'data': opt_class.serialize()}), 200


@app.route('/api/class/<int:class_id>/posts')
def get_posts(class_id):
    opt_class = Class.query.filter_by(id=class_id).first()
    if opt_class is not None:
        posts = Post.query.filter_by(post_id=class_id)
        res = {'success': True, 'data': [p.serialize() for p in posts]}
        return json.dumps(res), 200
    return json.dumps({'success': False, 'data': 'Class not found!'}), 404


@app.route('/api/class/<int:class_id>/post/', methods=['POST'])
def create_post(class_id):
    seletced_class = Class.query.filter_by(id=class_id).first()
    if seletced_class is not None:
        post_body = json.loads(request.data)
        if 'text' not in post_body or 'student_id' not in post_body:
            return json.dumps({'success': False, 'data': "Incorrect input format!"}), 404
        text = post_body.get('text')
        class_id = class_id
        student_id = post_body.get('student_id')
        post = Post(
            text=text,
            class_id=class_id,
            student_id=student_id
        )
        db.session.add(post)
        db.session.commit()
        return json.dumps({'success': True, 'data': post.serialize()}), 201
    return json.dumps({'success': False, 'error': 'Post is for an invalid class'}), 404


@app.route('/api/class/<int:post_id>/post/', methods=['DELETE'])
def delete_post(post_id):
    opt_post = Class.query.filter_by(id=post_id).first()
    if opt_post is not None:
        db.session.delete(post_id)
        db.session.commit()
        return json.dumps({'success': True, 'data': opt_post.serialize()}), 200
    return json.dumps({'success': False, 'data': 'Post not found!'}), 404


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
