#!/bin/bash

echo ""
echo "Applying migration PercentageTurnoverFromArt"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /percentageTurnoverFromArt                        controllers.PercentageTurnoverFromArtController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /percentageTurnoverFromArt                        controllers.PercentageTurnoverFromArtController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changePercentageTurnoverFromArt                  controllers.PercentageTurnoverFromArtController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changePercentageTurnoverFromArt                  controllers.PercentageTurnoverFromArtController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "percentageTurnoverFromArt.title = How much of your turnover do you expect to come from sales art for £10,000 or more?" >> ../conf/messages.en
echo "percentageTurnoverFromArt.heading = How much of your turnover do you expect to come from sales art for £10,000 or more?" >> ../conf/messages.en
echo "percentageTurnoverFromArt.zeroToTwenty = 0% to 20%" >> ../conf/messages.en
echo "percentageTurnoverFromArt.twentyOneToForty = 21% to 40%" >> ../conf/messages.en
echo "percentageTurnoverFromArt.checkYourAnswersLabel = How much of your turnover do you expect to come from sales art for £10,000 or more?" >> ../conf/messages.en
echo "percentageTurnoverFromArt.error.required = Select percentageTurnoverFromArt" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryPercentageTurnoverFromArtUserAnswersEntry: Arbitrary[(PercentageTurnoverFromArtPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[PercentageTurnoverFromArtPage.type]";\
    print "        value <- arbitrary[PercentageTurnoverFromArt].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryPercentageTurnoverFromArtPage: Arbitrary[PercentageTurnoverFromArtPage.type] =";\
    print "    Arbitrary(PercentageTurnoverFromArtPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryPercentageTurnoverFromArt: Arbitrary[PercentageTurnoverFromArt] =";\
    print "    Arbitrary {";\
    print "      Gen.oneOf(PercentageTurnoverFromArt.values.toSeq)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(PercentageTurnoverFromArtPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class/ {\
     print;\
     print "";\
     print "  def percentageTurnoverFromArt: Option[AnswerRow] = userAnswers.get(PercentageTurnoverFromArtPage) map {";\
     print "    x =>";\
     print "      AnswerRow(";\
     print "        HtmlFormat.escape(messages(\"percentageTurnoverFromArt.checkYourAnswersLabel\")),";\
     print "        HtmlFormat.escape(messages(s\"percentageTurnoverFromArt.$x\")),";\
     print "        routes.PercentageTurnoverFromArtController.onPageLoad(CheckMode).url";\
     print "      )"
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration PercentageTurnoverFromArt completed"
