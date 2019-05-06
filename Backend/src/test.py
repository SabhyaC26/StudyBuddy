import unittest
import json
import requests
from app import app
from threading import Thread
from time import sleep

# NOTE: Make sure you run 'pip3 install requests' in your virtualenv

# URL pointing to you local dev host
LOCAL_URL = 'http://localhost:5000'


class TestRoutes(unittest.TestCase):

    def test_defualt_route(self):
        res = requests.get(LOCAL_URL + '/')
        assert res.json()['success']

    def test_create_class(self):
        pass

    def test_get_classes(self):
        pass

    def test_get_class_by_id(self):
        pass

    def test_delete_class(self):
        pass

    def test_create_student(self):
        pass

    def test_get_student(self):
        pass

    def test_delete_student(self):
        pass

    def test_add_student_to_class(self):
        pass

    def test_remove_student_from_class(self):
        pass

    def test_create_post(self):
        pass

    def test_get_posts(self):
        pass

    def test_delete_posts(self):
        pass


def run_tests():
    sleep(1.5)
    unittest.main()


if __name__ == '__main__':
    thread = Thread(target=run_tests)
    thread.start()
    app.run(host='0.0.0.0', port=5000, debug=False)
