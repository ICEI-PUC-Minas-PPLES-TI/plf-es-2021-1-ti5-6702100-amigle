const Page = require('./page');

class MainPage extends Page {

    get mainTitle () { return $('//*[@id="welcomeText"]') }
    get startConversationLink () { return $('//*[@id="startChatButton"]/div') }
    get allTagsButton () { return $('//*[@id="allTagsButton"]/div') }
    get specificTagButton () { return $('//*[@id="specificTagButton"]/div') }
    get loadingText () { return $('//*[@id="searchingText"]') }
    get chooseTagText () { return $('/html/body/div[2]/main/section/div[3]/div[1]/div/h2') }
    
}

module.exports = new MainPage();