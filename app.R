library(shiny)
library(tidyverse)
library(googledrive)
library(googlesheets4)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyjs)
options(gargle_oauth_cache = ".secrets")
gargle::gargle_oauth_cache()
drive_auth()
list.files(".secrets/")



ui <- dashboardPage(skin = "black", 
                    dashboardHeader(titleWidth = 350, title = ""), 
                    dashboardSidebar(width = 350, collapsed = TRUE,
                                     sidebarMenu(id = "tabs",
                                                 menuItem("About", tabName = "About", icon = icon("th")),
                                                 menuItem("Complete the Questionnaire", tabName = "BFS", icon = icon("th"))
                                                 
                                     )
                    ),
                    
                    
                    dashboardBody(useShinyjs(),
                        tabItems(
                            tabItem(tabName = "About", value ="About",
                                    box(width = 40,
                                        box(width = 30, title = "", style = "font-size:150%",
                                            br(),
                                            "You are invited to participate in a research study which focuses on personality and personality functioning. 
                                        The aim of this research study is to broaden our understanding of specific traits by investigating how they 
                                        mutually interact and influence each another as well as their relation to counterproductive work behaviour. 
                                        By participating you help us to understand these processes. The questionnaire contains 
                                        32 items about counterproductive behaviour at work and 140 personality items. It takes approximately 15-20 minutes
                                        to complete. You need to be 18 years or older and have a minimum of 8 years of prior schooling to participate. This questionnaire
                                        is COMPLETELY ANONYMOUS as we need particiants to be entirely honest for the research to be meaningful. Participation is 
                                        voluntary. As such, by completing the questionnaire, you consent to participating in the study. You have the right to 
                                        withdraw from the study at any stage should you wish to do so. To continue, Click 'Proceed' below, then, read the instructions,
                                        complete the questions, and press 'Submit' when you are finished."  
                                        ),
                                        
                                        actionButton("jumptoBFS", "Proceed"))
                            ),
                            
                            
                            tabItem(tabName = "BFS", value = "BFS",
                                    # conditionalPanel("input.n == 1",   
                                    box(width = 40,    
                                        br(),
                                        box(width = 38, style = "font-size:150%",
                                            strong("General Instructions: Please provide relevant demographic information below (leaving out Name and Surname as this survey is anonymous).
                                                      Please start at Section A and continue to the end at 'Submit'. We ask that you do the questions in order to prevent accidentally skipping one."),
                                        ),
                                        br(),
                                        fluidRow(         
                                            box(
                                                box(textInput("Name", "Name")),
                                                box(textInput("Surname", "Surname"))
                                            ),
                                            
                                            box(
                                                box(textInput("Age", "Age", width = '100px')), 
                                                box(dateInput("dob", label="Date of Birth",
                                                              min = "1940-01-01",
                                                              max = Sys.Date(), format = "yyyy-mm-dd", 
                                                              startview = "year",
                                                              weekstart = 0, language = "en"))
                                            ),
                                            
                                            box(
                                                box(selectInput("Education", "Education", c("Grade 10/11", "Grade 12", "Diploma", "B-degree", "Hons Degree", "Masters", "Doctorate"), selected = "Grade 12")),
                                                box(selectInput("Language", "Language", c("English", "isiZulu", "isiXhosa", "Afrikaans", "Tsivenda", "Sepedi", "Setswana", "isiNdebele", "Sesotho", "siSwati", "Xitsonga")))
                                            ),
                                            
                                            
                                            box(
                                                box(selectInput("Employment status", "Employment status", c("Currently unemployed","Student","Self-employed" ,"Worker", "Supervisor", "Middle Management", "Senior Management", "Executive", "Professional (eg. Lawyer, Doctor"), selected = "Self-employed")),
                                                box(selectInput("Gender", "Gender", c("Male", "Female", "Other")))
                                            ),
                                        ), # close fluidRow
                                        
                                        box(width = 38, style = "font-size:150%",
                                            strong("SECTION A - Instructions: Please indicate how often have you done each of the following things on your present job?
                                                                1=Never | 2=Once or Twice | 3=Once or Twice per Month | 4=Once or Twice per Week | 5=Every Day. 
                                                                Please provide honest responses as this survey is completely anonymous. (If you have never been 
                                                                employed, please skip this section and continue to Section B below)"),
                                        ),
                                        
                                        box(width = 38,     
                                            box(width = 36,  # contains 2 columns of CWB items
                                                column(width = 6,
                                                       box(
                                                           width = NULL, title = "",
                                                           sliderInput("CWB_1", "1.	Purposely wasted your employer's materials/supplies  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_2", "2.	Purposely did your work incorrectly  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_3", "3.	Came to work late without permission  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_4", "4.	Stayed home from work and said you were sick when you weren't  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_5", "5.	Purposely damaged a piece of equipment or property  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_6", "6.	Purposely dirtied or littered your place of work  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_7", "7.	Stolen something belonging to your employer  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_8", "8.	Started or continued a damaging or harmful rumor at work  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_9", "9.	Been nasty or rude to a client or customer  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_10", "10.	Purposely worked slowly when things needed to get done  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_11", "11.	Taken a longer break than you were allowed to take  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_12", "12.	Purposely failed to follow instructions  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_13", "13.	Left work earlier than you were allowed to  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_14", "14.	Insulted someone about their job performance  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_15", "15.	Made fun of someone's personal life  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_16", "16.	Took supplies or tools home without permission  ", width = '425px', 1, 5, 1),
                                                       )
                                                ),
                                                column(width = 6,
                                                       box(
                                                           width = NULL, title = "",
                                                           sliderInput("CWB_17", "17.	Put in to be paid for more hours than you worked  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_18", "18.	Took money from your employer without permission  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_19", "19.	Ignored someone at work  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_20", "20.	Blamed someone at work for error you made  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_21", "21.	Started an argument with someone at work  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_22", "22.	Stole something belonging to someone at work  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_23", "23.	Verbally abused someone at work  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_24", "24.	Made an obscene gesture (the finger) to someone at work  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_25", "25.	Threatened someone at work with violence  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_26", "26.	Threatened someone at work, but not physically  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_27", "27.	Said something obscene to someone at work to make them feel bad  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_28", "28.	Did something to make someone at work look bad  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_29", "29.	Played a mean prank to embarrass someone at work  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_30", "30.	Looked at someone at work's private mail/property without permission  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_31", "31.	Hit or pushed someone at work  ", width = '425px', 1, 5, 1),
                                                           sliderInput("CWB_32", "32.	Insulted or made fun of someone at work  ", width = '425px', 1, 5, 1),
                                                       )
                                                )
                                            )
                                        ),
                                        
                                        box(width = 38, style = "font-size:150%",
                                            strong("SECTION B - Instructions: This is a list of things different people might say about themselves. We are interested in how you would describe yourself.  
                                                                                 There are no right or wrong answers. So you can describe yourself as honestly as possible, we will keep your responses confidential. We'd like 
                                                                                 you to take your time and read each statement carefully, selecting the response that best describes you. 1=Very False or Often False |
                                                                                 2=Sometimes or Somewhat False | 3=Sometimes or Somewhat True | 4=Very True or Often True"),
                                        ),
                                        
                                        
                                        box(width = 38, # contains 2 columns of PID5 items   
                                            box(width = 36,
                                                column(width = 6,
                                                       box(
                                                           width = NULL, title = "",
                                                           sliderInput("PID_1", "1. Plenty of people are out to get me.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_2", "2. I feel like I act totally on impulse.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_3", "3. I change what I do depending on what others want.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_4", "4 .I usually do what others think I should do.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_5", "5. I usually do things on impulse without thinking about what might happen as a result.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_6", "6. Even though I know better, I can't stop making rash decisions.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_7", "7. I really don't care if I make other people suffer.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_8", "8. I always do things on the spur of the moment.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_9", "9. Nothing seems to interest me very much.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_10", "10. People have told me that I think about things in a really strange way.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_11", "11. I almost never enjoy life.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_12", "12. I am easily angered.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_13", "13. I have no limits when it comes to doing dangerous things.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_14", "14. To be honest, I'm just more important than other people.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_15", "15. It's weird, but sometimes ordinary objects seem to be a different shape than usual.    ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_16", "16. I do a lot of things that others consider risky.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_17", "17. I worry a lot about being alone.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_18", "18. I often make up things about myself to help me get what I want.   ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_19", "19. I keep approaching things the same way, even when it isn't working  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_20", "20. I do what other people tell me to do.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_21", "21. I like to take risks  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_22", "22. Others seem to think I'm quite odd or unusual.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_23", "23. I love getting the attention of other people.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_24", "24. I worry a lot about terrible things that might happen.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_25", "25. I have trouble changing how I'm doing something even if what I'm doing isn't going well.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_26", "26. The world would be better off if I were dead.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_27", "27. I keep my distance from people.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_28", "28. I don't get emotional.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_29", "29. I prefer to keep romance out of my life.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_30", "30. I don't show emotions strongly.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_31", "31. I have a very short temper. ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_32", "32. I get fixated on certain things and can't stop.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_33", "33. If something I do isn't absolutely perfect, it's simply not acceptable.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_34", "34. I often have unusual experiences, such as sensing the presence of someone who isn't actually there.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_35", "35. I'm good at making people do what I want them to do.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_36", "36. I'm always worrying about something.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_37", "37. I'm better than almost everyone else.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_38", "38. I'm always on my guard for someone trying to trick or harm me.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_39", "39. I have trouble keeping my mind focused on what needs to be done.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_40", "40. I'm just not very interested in having sexual relationships.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_41", "41. I get emotional easily, often for very little reason.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_42", "42. Even though it drives other people crazy, I insist on absolute perfection in everything I do.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_43", "43. I almost never feel happy about my day-to-day activities.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_44", "44. Sweet-talking others helps me get what I want.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_45", "45. I fear being alone in life more than anything else  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_46", "46. I get stuck on one way of doing things, even when it's clear it won't work.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_47", "47. I'm often pretty careless with my own and others' things.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_48", "48. I am a very anxious person.", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_49", "49. I am easily distracted.                                                      ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_50", "50. It seems like I'm always getting a 'raw deal' from others.                         ", width = '425px', 1, 4,  1),
                                                       )
                                                ), 
                                                column(width = 6,
                                                       box(
                                                           width = NULL, title = "",
                                                           sliderInput("PID_51", "51. I don't hesitate to cheat if it gets me ahead.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_52", "52. I don't like spending time with others.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_53", "53. I never know where my emotions will go from moment to moment.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_54", "54. I have seen things that weren't really there.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_55", "55. I can't focus on things for very long.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_56", "56. I steer clear of romantic relationships.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_57", "57. I'm not interested in making friends.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_58", "58. I'll do just about anything to keep someone from abandoning me.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_59", "59. Sometimes I can influence other people just by sending my thoughts to them.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_60", "60. Life looks pretty bleak to me.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_61", "61. I think about things in odd ways that don't make sense to most people.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_62", "62. I don't care if my actions hurt others.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_63", "63. Sometimes I feel 'controlled' by thoughts that belong to someone else.", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_64", "64. I make promises that I don't really intend to keep.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_65", "65. Nothing seems to make me feel good.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_66", "66. I get irritated easily by all sorts of things.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_67", "67. I do what I want regardless of how unsafe it might be.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_68", "68. I often forget to pay my bills.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_69", "69. I'm good at conning people.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_70", "70. Everything seems pointless to me.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_71", "71. I get emotional over every little thing.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_72", "72. It's no big deal if I hurt other peoples' feelings.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_73", "73. I never show emotions to others.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_74", "74. I have no worth as a person.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_75", "75. I am usually pretty hostile.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_76", "76. I've skipped town to avoid responsibilities.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_77", "77. I like being a person who gets noticed.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_78", "78. I'm always fearful or on edge about bad things that might happen.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_79", "79. I never want to be alone.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_80", "80. I keep trying to make things perfect, even when I've gotten them as good as they're likely to get.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_81", "81. My emotions are unpredictable.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_82", "82. I don't care about other peoples' problems.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_83", "83. I don't react much to things that seem to make others emotional.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_84", "84. I avoid social events.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_85", "85. I deserve special treatment.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_86", "86. I suspect that even my so-called 'friends' betray me a lot.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_87", "87. I crave attention.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_88", "88. Sometimes I think someone else is removing thoughts from my head.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_89", "89. I simply won't put up with things being out of their proper places.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_90", "90. I often have to deal with people who are less important than me.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_91", "91. I get pulled off-task by even minor distractions.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_92", "92. I try to do what others want me to do.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_93", "93. I prefer being alone to having a close romantic partner.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_94", "94. I often have thoughts that make sense to me but that other people say are strange.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_95", "95. I use people to get what I want.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_96", "96. I've had some really weird experiences that are very difficult to explain.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_97", "97. I like to draw attention to myself.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_98", "98. Things around me often feel unreal, or more real than usual.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_99", "99. I'll stretch the truth if it's to my advantage.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("PID_100", "100. It is easy for me to take advantage of others.                         ", width = '425px', 1, 4,  1)
                                                       ) 
                                                )   
                                            )          
                                        ),               
                                        
                                        box(width = 38, style = "font-size:130%",
                                            strong("SECTION C - Like above, the following statements also relate to your everyday thoughts, feelings and behaviours.
                                                             Please read each statement carefully and select the answer that best describes how you usually think and 
                                                             feel by selecting one of the follwing: 1= Stongly Disagree | 2=Disagree | 3=Neither Agree nor Disagree | 4=Agree | 5=Strongly Agree. 
                                                             Again, please describe yourself honestly as you are, and not as you would like to be.")
                                        ),
                                        
                                        box(width = 38, # contains 2 columns of H-H  items  
                                            box(width = 36, 
                                                column(width = 6,
                                                       box(
                                                         width = NULL, title = "",
                                                         sliderInput("HH_SINC_1", "1. I sometimes pretend to be more than I am.", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_FAIR_1", "2. I would never take things that aren't mine.  ", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_GREED_1", "3. I would enjoy being a famous celebrity.  ", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_MOD_1", "4. I think that I'm better than most other people.   ", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_SINC_2", "5. I use of flattery to get ahead. ", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_FAIR_2", "6. I would cheat on my taxes.  ", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_GREED_2", "7. I don't strive for elegance in my appearance.  ", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_MOD_2", "8. I see myself as an average person.   ", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_SINC_3", "9. I tell other people what they want to hear so that they will do what I want them to do.", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_FAIR_3", "10. I alwys return extra change when a cashier makes a mistake. ", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_GREED_3", "11. I love luxury.  ", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_MOD_3", "12. I'm just an ordinary person.", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_SINC_4", "13. I sometimes put on a 'show' to impress people.", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_FAIR_4", "14. I think I would feel very badly if I were to steal anything from someone else.", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_GREED_4", "15. I have a strong need for power. ", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_MOD_4", "16. I consider myself just an average person.", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_SINC_5", "17. I would switch my loyalties should I need to.", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_FAIR_5", "18. I try to follow the rules.", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_GREED_5", "19. I strive to be a high status person.", width = '425px', 1, 4,  1),
                                                         sliderInput("HH_MOD_5", "20. I would like to have more power than other people.", width = '425px', 1, 4,  1),
                                                       )
                                                ), 
                                                column(width = 6,
                                                       box(style = "padding-bottom:50px",
                                                           width = NULL, title = "",
                                                           sliderInput("HH_SINC_6", "21. I often act like someone I'm not to impress people.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_FAIR_6", "22. I admire a really clever scam. ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_GREED_6", "23. I am mainly interested in money. ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_MOD_6", "24. I believe that I'm better than others.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_SINC_7", "25. I often pretend to be concerned for others. ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_FAIR_7", "26. It's okay to cheat if it helps me to get ahead. ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_GREED_7", "27. I wish to stay young forever.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_MOD_7", "28. I like it when I attract attention.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_SINC_8", "29. I act like different people in different situations.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_FAIR_8", "30. I tend to steal things.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_GREED_8", "31. I try to impress other people. ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_MOD_8", "32. I think I'm more capable than most others. ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_SINC_9", "33. I find it is necessary to please people who have power. ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_FAIR_9", "34. I have cheated on, or lied, to people who have trusted me. ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_GREED_9", "35. I prefer to eat at expensive restaurants. ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_MOD_9", "36. I am likely to show off if I get the chance. ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_SINC_10", "37. I let people push me around to help them feel important.  ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_FAIR_10", "38. I don't think I'll regret taking advantage of someone. ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_GREED_10", "39. I live life for my own personal gain. ", width = '425px', 1, 4,  1),
                                                           sliderInput("HH_MOD_10", "40. I tend to boast about my virtues (goodness).  ", width = '425px', 1, 4,  1)
                                                       ) 
                                                )   
                                            )          
                                        ),
                                        
                                        actionButton("submit", "Submit"),
                                        
                                        
                                        
                                        hidden(
                                          div(
                                            id = "thankyou_msg",
                                            h4("Thank you for your participation! Your responses were submitted successfully. You can close this window.")
                                            
                                          )
                                        )
                                        
                                        
                                        
                                        
                                    ) # close big container box   
                                    
                            ) # close BFS tab
                            
                            
                            
                            
                            
                            
                        ) # close TabItems
                    ) # close DashboadBody
)                                 


server <- function(input, output, session) {
    
    observeEvent(input$jumptoBFS, {
        newtab <- switch(input$tabs,
                         "About" = "BFS",
                         "BFS" = "About")    
        updateTabItems(session, "tabs", newtab)
    })
    

    
    observeEvent(input$submit, {                                                                 
        
        
        pid <- drive_get("PID5_CWB")
        new_subject <- data.frame(
            Name = input$Name,
            Surname = input$Surname,
            dob = input$dob,
            Age = input$Age,
            Gender = input$Gender,
            Ethnicity = input$Ethnicity,
            Language = input$Language,
            Education = input$Education,
            CWB_1 = input$CWB_1,
            CWB_2 = input$CWB_2,
            CWB_3 = input$CWB_3,
            CWB_4 = input$CWB_4,
            CWB_5 = input$CWB_5,
            CWB_6 = input$CWB_6,
            CWB_7 = input$CWB_7,
            CWB_8 = input$CWB_8,
            CWB_9 = input$CWB_9,
            CWB_10 = input$CWB_10,
            CWB_11 = input$CWB_11,
            CWB_12 = input$CWB_12,
            CWB_13 = input$CWB_13,
            CWB_14 = input$CWB_14,
            CWB_15 = input$CWB_15,
            CWB_16 = input$CWB_16,    
            CWB_17 = input$CWB_17,
            CWB_18 = input$CWB_18,    
            CWB_19 = input$CWB_19,    
            CWB_20 = input$CWB_20,    
            CWB_21 = input$CWB_21,    
            CWB_22 = input$CWB_22,    
            CWB_23 = input$CWB_23,    
            CWB_24 = input$CWB_24,    
            CWB_25 = input$CWB_25,    
            CWB_26 = input$CWB_26,    
            CWB_27 = input$CWB_27,    
            CWB_28 = input$CWB_28,    
            CWB_29 = input$CWB_29,    
            CWB_30 = input$CWB_30,    
            CWB_31 = input$CWB_31,
            CWB_32 = input$CWB_32,
            PID_1 = input$PID_1,    
            PID_2 = input$PID_2,
            PID_3 = input$PID_3,   
            PID_4 = input$PID_4,   
            PID_5 = input$PID_5,   
            PID_6 = input$PID_6,   
            PID_7 = input$PID_7,   
            PID_8 = input$PID_8,   
            PID_9 = input$PID_9,   
            PID_10 = input$PID_10,    
            PID_11 = input$PID_11,    
            PID_12 = input$PID_12,    
            PID_13 = input$PID_13,    
            PID_14 = input$PID_14,    
            PID_15 = input$PID_15,    
            PID_16 = input$PID_16,    
            PID_17 = input$PID_17,    
            PID_18 = input$PID_18,    
            PID_19 = input$PID_19,    
            PID_20 = input$PID_20,    
            PID_21 = input$PID_21,    
            PID_22 = input$PID_22,    
            PID_23 = input$PID_23,    
            PID_24 = input$PID_24,    
            PID_25 = input$PID_25,    
            PID_26 = input$PID_26,    
            PID_27 = input$PID_27,    
            PID_28 = input$PID_28,    
            PID_29 = input$PID_29,    
            PID_30 = input$PID_30,    
            PID_31 = input$PID_31,    
            PID_32 = input$PID_32,    
            PID_33 = input$PID_33,    
            PID_34 = input$PID_34,    
            PID_35 = input$PID_35,    
            PID_36 = input$PID_36,    
            PID_37 = input$PID_37,    
            PID_38 = input$PID_38,    
            PID_39 = input$PID_39,    
            PID_40 = input$PID_40,    
            PID_41 = input$PID_41,    
            PID_42 = input$PID_42,    
            PID_43 = input$PID_43,    
            PID_44 = input$PID_44,    
            PID_45 = input$PID_45,    
            PID_46 = input$PID_46,    
            PID_47 = input$PID_47,    
            PID_48 = input$PID_48,    
            PID_49 = input$PID_49,    
            PID_50 = input$PID_50,
            PID_51 = input$PID_51,    
            PID_52 = input$PID_52,    
            PID_53 = input$PID_53,    
            PID_54 = input$PID_54,    
            PID_55 = input$PID_55,    
            PID_56 = input$PID_56,    
            PID_57 = input$PID_57,    
            PID_58 = input$PID_58,    
            PID_59 = input$PID_59,    
            PID_60 = input$PID_60,    
            PID_61 = input$PID_61,    
            PID_62 = input$PID_62,    
            PID_63 = input$PID_63,    
            PID_64 = input$PID_64,    
            PID_65 = input$PID_65,    
            PID_66 = input$PID_66,    
            PID_67 = input$PID_67,    
            PID_68 = input$PID_68,    
            PID_69 = input$PID_69,    
            PID_70 = input$PID_70,    
            PID_71 = input$PID_71,    
            PID_72 = input$PID_72,    
            PID_73 = input$PID_73,    
            PID_74 = input$PID_74,    
            PID_75 = input$PID_75,    
            PID_76 = input$PID_76,    
            PID_77 = input$PID_77,    
            PID_78 = input$PID_78,    
            PID_79 = input$PID_79,    
            PID_80 = input$PID_80,    
            PID_81 = input$PID_81,    
            PID_82 = input$PID_82,    
            PID_83 = input$PID_83,    
            PID_84 = input$PID_84,    
            PID_85 = input$PID_85,    
            PID_86 = input$PID_86,    
            PID_87 = input$PID_87,    
            PID_88 = input$PID_88,    
            PID_89 = input$PID_89,    
            PID_90 = input$PID_90,    
            PID_91 = input$PID_91,    
            PID_92 = input$PID_92,    
            PID_93 = input$PID_93,    
            PID_94 = input$PID_94,    
            PID_95 = input$PID_95,    
            PID_96 = input$PID_96,    
            PID_97 = input$PID_97,    
            PID_98 = input$PID_98,    
            PID_99 = input$PID_99,    
            PID_100 = input$PID_100,
            HH_SINC_1	= input$HH_SINC_1,
            HH_FAIR_1	= input$HH_FAIR_1,  
            HH_GREED_1 = input$HH_GREED_1, 
            HH_MOD_1	= input$HH_MOD_1,	
            HH_SINC_2	= input$HH_SINC_2,
            HH_FAIR_2	= input$HH_FAIR_2,
            HH_GREED_2	= input$HH_GREED_2,
            HH_MOD_2	= input$HH_MOD_2,
            HH_SINC_3	=input$HH_SINC_3,
            HH_FAIR_3	=input$HH_FAIR_3,
            HH_GREED_3	=input$HH_GREED_3,
            HH_MOD_3	=input$HH_MOD_3,
            HH_SINC_4	=input$HH_SINC_4,
            HH_FAIR_4	=input$HH_FAIR_4,
            HH_GREED_4	=input$HH_GREED_4,
            HH_MOD_4	=input$HH_MOD_4,
            HH_SINC_5	=input$HH_SINC_5,
            HH_FAIR_5	=input$HH_FAIR_5,
            HH_GREED_5	=input$HH_GREED_5,
            HH_MOD_5	=input$HH_MOD_5,
            HH_SINC_6	=input$HH_SINC_6,
            HH_FAIR_6	=input$HH_FAIR_6,
            HH_GREED_6	=input$HH_GREED_6,
            HH_MOD_6	=input$HH_MOD_6,
            HH_SINC_7	=input$HH_SINC_7,
            HH_FAIR_7	=input$HH_FAIR_7,
            HH_GREED_7	=input$HH_GREED_7,
            HH_MOD_7	=input$HH_MOD_7,
            HH_SINC_8	=input$HH_SINC_8,
            HH_FAIR_8	=input$HH_FAIR_8,
            HH_GREED_8	=input$HH_GREED_8,
            HH_MOD_8	=input$HH_MOD_8,
            HH_SINC_9	=input$HH_SINC_9,
            HH_FAIR_9	=input$HH_FAIR_9,
            HH_GREED_9	=input$HH_GREED_9,
            HH_MOD_9	=input$HH_MOD_9,
            HH_SINC_10	=input$HH_SINC_10,
            HH_FAIR_10	=input$HH_FAIR_10,
            HH_GREED_10	=input$HH_GREED_10,
            HH_MOD_10	=input$HH_MOD_10)
        
        
        
        pid %>%
            sheet_append(new_subject, "item_data") 
   
        
        shinyjs::show("thankyou_msg")
        
         })
    
    
    
}

shinyApp(ui, server)


