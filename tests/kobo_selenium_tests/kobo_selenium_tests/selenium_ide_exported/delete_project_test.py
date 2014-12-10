# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class DeleteProjectTest(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "http://kc.kbtdev.org/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_delete_project(self):
        driver = self.driver
        driver.get(self.base_url + "")
        self.assertTrue(self.is_element_present(By.LINK_TEXT, "Selenium test form title."))
        driver.find_element_by_link_text("Selenium test form title.").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".single-project__toggle-settings .fa-cog"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        for i in range(60):
            try:
                if driver.find_element_by_css_selector(".single-project__toggle-settings .fa-cog").is_displayed(): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector(".single-project__toggle-settings .fa-cog").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, "button.single-project__button.single-project__button-delete"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector("button.single-project__button.single-project__button-delete").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".modal .btn-primary"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        for i in range(60):
            try:
                if driver.find_element_by_css_selector(".modal .btn-primary").is_displayed(): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector(".modal .btn-primary").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".projects-list__header"): break
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
