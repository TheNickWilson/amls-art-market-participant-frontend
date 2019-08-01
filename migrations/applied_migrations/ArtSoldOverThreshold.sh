#!/bin/bash

echo ""
echo "Applying migration ArtSoldOverThreshold"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /artSoldOverThreshold                        controllers.ArtSoldOverThresholdController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /artSoldOverThreshold                        controllers.ArtSoldOverThresholdController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeArtSoldOverThreshold                  controllers.ArtSoldOverThresholdController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeArtSoldOverThreshold                  controllers.ArtSoldOverThresholdController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "artSoldOverThreshold.title = artSoldOverThreshold" >> ../conf/messages.en
echo "artSoldOverThreshold.heading = artSoldOverThreshold" >> ../conf/messages.en
echo "artSoldOverThreshold.checkYourAnswersLabel = artSoldOverThreshold" >> ../conf/messages.en
echo "artSoldOverThreshold.error.required = Select yes if artSoldOverThreshold" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryArtSoldOverThresholdUserAnswersEntry: Arbitrary[(ArtSoldOverThresholdPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[ArtSoldOverThresholdPage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryArtSoldOverThresholdPage: Arbitrary[ArtSoldOverThresholdPage.type] =";\
    print "    Arbitrary(ArtSoldOverThresholdPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(ArtSoldOverThresholdPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class/ {\
     print;\
     print "";\
     print "  def artSoldOverThreshold: Option[AnswerRow] = userAnswers.get(ArtSoldOverThresholdPage) map {";\
     print "    x =>";\
     print "      AnswerRow(";\
     print "        HtmlFormat.escape(messages(\"artSoldOverThreshold.checkYourAnswersLabel\")),";\
     print "        yesOrNo(x),";\
     print "        routes.ArtSoldOverThresholdController.onPageLoad(CheckMode).url";\
     print "      )"
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration ArtSoldOverThreshold completed"
