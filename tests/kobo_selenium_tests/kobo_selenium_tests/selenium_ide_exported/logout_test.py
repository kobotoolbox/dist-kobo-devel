# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class LogoutTest(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "http://kf.kbtdev.org/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_logout(self):
        driver = self.driver
        driver.get(self.base_url + "")
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".header-bar__top-level-menu-button .fa-bars"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector(".header-bar__top-level-menu-button .fa-bars").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".top-level-menu .fa-sign-out"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        for i in range(60):
            try:
                if driver.find_element_by_css_selector(".top-level-menu .fa-sign-out").is_displayed(): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector(".top-level-menu .fa-sign-out").click()
        for i in range(60):
            try:
                if self.is_element_present(By.ID, "id_username"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
    
    def is_element_present(self, how, what):
        try: self.driver.find_element(by=how, value=what)
        except NoSuchElementException, e: return False
        return True
    
    def is_alert_present(self):
        try: self.driver.switch_to_alert()
        except NoAlertPresentException, e: return False
        return True
    
    def close_alert_and_get_its_text(self):
        try:
            alert = self.driver.switch_to_alert()
            alert_text = alert.text
            if self.accept_next_alert:
                alert.accept()
            else:
                alert.dismiss()
            return alert_text
        finally: self.accept_next_alert = True
    
    def tearDown(self):
        self.driver.quit()
        self.assertEqual([], self.verificationErrors)

if __name__ == "__main__":
    unittest.main()
