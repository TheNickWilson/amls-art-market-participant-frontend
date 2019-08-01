#!/bin/bash

echo ""
echo "Applying migration DateSoldOverThreshold"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /dateSoldOverThreshold                  controllers.DateSoldOverThresholdController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /dateSoldOverThreshold                  controllers.DateSoldOverThresholdController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeDateSoldOverThreshold                        controllers.DateSoldOverThresholdController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeDateSoldOverThreshold                        controllers.DateSoldOverThresholdController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "dateSoldOverThreshold.title = DateSoldOverThreshold" >> ../conf/messages.en
echo "dateSoldOverThreshold.heading = DateSoldOverThreshold" >> ../conf/messages.en
echo "dateSoldOverThreshold.checkYourAnswersLabel = DateSoldOverThreshold" >> ../conf/messages.en
echo "dateSoldOverThreshold.error.required.all = Enter the dateSoldOverThreshold" >> ../conf/messages.en
echo "dateSoldOverThreshold.error.required.two = The dateSoldOverThreshold" must include {0} and {1} >> ../conf/messages.en
echo "dateSoldOverThreshold.error.required = The dateSoldOverThreshold must include {0}" >> ../conf/messages.en
echo "dateSoldOverThreshold.error.invalid = Enter a real DateSoldOverThreshold" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDateSoldOverThresholdUserAnswersEntry: Arbitrary[(DateSoldOverThresholdPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[DateSoldOverThresholdPage.type]";\
    print "        value <- arbitrary[Int].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDateSoldOverThresholdPage: Arbitrary[DateSoldOverThresholdPage.type] =";\
    print "    Arbitrary(DateSoldOverThresholdPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(DateSoldOverThresholdPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def dateSoldOverThreshold: Option[AnswerRow] = userAnswers.get(DateSoldOverThresholdPage) map {";\
     print "    x =>";\
     print "      AnswerRow(";\
     print "        HtmlFormat.escape(messages(\"dateSoldOverThreshold.checkYourAnswersLabel\")),";\
     print "        HtmlFormat.escape(x.format(dateFormatter)),";\
     print "        routes.DateSoldOverThresholdController.onPageLoad(CheckMode).url";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration DateSoldOverThreshold completed"
