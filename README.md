Sign up from the Lightning Platform Workshops Launchpad (https://lightning-platform-workshops.herokuapp.com/).
there's a nicer version of this guide here (https://c1.sfdcstatic.com/content/dam/web/en_us/www/documents/campaign/lightning-platform-wsiab/workshop-guide-6-Make-Salesforce-Your-Back-Office-Agility-Layer.pdf)


Introduction

For many of our customers running Salesforce, there's always something that people need access to that doesn't live in Salesforce.  It could be ERP data like invoices or orders in SAP or Oracle—you need those to sell and market to your customers.  Or it could be HR data, or something custom stored in a SQL database.

Of course, you could rebuild that schema in Salesforce and use a middleware tool to copy the data over, and sometimes that's the right choice.

But what if you could leave that data where it is, and just have Salesforce *ACT* like it has the data...you could run reports, attach files in chatter, create field layouts and custom lightning pages, have those records on your phone in the Salesforce Mobile App, share them with customers and partners in a community...basically doing the things you always do with data in Salesforce.

Salesforce Connect lets you do that!

Step 1: Setup the endpoint

From *Setup > External Data Sources*, select *New External Data Source*.  An external data source is the address where the service lives.

Name the data source *OrderDB*, and select *Salesforce Connect: OData 2.0* as the type.  There are different connectors, (for example, you might be connecting 2 salesforce orgs together!) and developers can create their own connectors.
[Image: Screen Shot 2017-09-21 at 2.28.31 PM.png]
Enter http://orderdb.herokuapp.com/orders.svc as the URL.  

As you can see, there's some options you can control, as well as authentication settings.  We'll leave all those alone.

In real life, you'd have login credentials, and maybe even a security certificate, so the external service knows that you're legit.  To make your life easier in our workshop, we've left the service open to everyone.

You could even check the “Writable External Objects” box and let Salesforce edit records your external system.  

*Save*.  On the next screen, click *Validate and Sync*.  Connect is asking the external service what tables it has available.  Your service might have 1, or hundreds.  You can choose which ones should be shown in Salesforce

Select both the *Orders* and *OrderDetails* tables, and click *Sync*.
[Image: Screen Shot 2017-09-21 at 4.04.48 PM.png]
Step 2

Let's create a tab so we can see those orders!  
*Setup | User Interface | **Tabs *> *New* (Custom Object Tab) > *Orders* > [pick some icon]
[Image: Screen Shot 2017-09-21 at 4.13.43 PM.png]Click *Next, Next, Save.  *Launch the *Sales* App from the App Launcher, click the *More* dropdown, and choose orders.

We haven't looked at any of these, ever, so there's nothing in recents.  Change the list View to from *Recently Viewed* to *All *and there's our orders.  Now, we can configure them like anything else in Salesforce. Click the little gear at the top left of the list view and *Select Fields to Display*
[Image: Screen Shot 2017-09-21 at 4.17.23 PM.png]

Get rid of that URL and add the other fields as shown.  

*Save*.  

When you load this list view, Connect is asking that external system for the list of orders.  And when you click on one [actually click on one], Salesforce is grabbing the order details from that external system.
[Image: Image.jpg]

Step 3: Relationships

Notice the orders have a Customer ID field?  Wouldn't it be cool if we could link that with a customer in Salesforce?  And when you look at an account, you'd want to see all their orders?  Let's do it!


1. From *Setup | Integrations | External Objects*, select *Orders*.
2. Next to the *customerID* field, click *Edit* and then click *Change Field Type*.
3. Select *Indirect Lookup Relationship* as the data type, and click *Next*.   An indirect relationship means that you don't have to change anything about the external system, but that Salesforce can use the external system's ID to create a link between them.
4. For the Related To value, select *Account* and then click *Next*.
5. For the Target Field value, select *Customer_ID__c* and and click *Next*.
6. Enter *18* as the field length. Leave the other options with their defaults. Click *Next*.
7. To make the field visible to all profiles, select the checkbox next to *Visible* and click *Next*. In a real production setting, you would carefully analyze who should have access to order data.
8. Leave all the checkboxes in their default state and click *Save*. A new Orders related list is added to the Account page layouts.


Check your work! Click the *Accounts* tab, and click *Go* to view all accounts. Click any sample account to see its details. Click on its *Related* tab and Scroll to the bottom to view a list of its orders. 

Salesforce just asked the external system for the orders that have match whatever account you clicked on. Click on one of the orders—you'll see the order and ship dates.  

But there's more to orders than that.  Let's add the order line items to the order screen.

Step 4: Order Details

1. From *Setup | Integrations | External Objects*, select *OrderDetails*.
2. Next to the *orderID* field, click *Edit* and then click *Change Field Type*.
3. Select *External Lookup Relationship* as the data type, and click *Next*.  External Lookups connect an external object to another external object!
4. For the Related To value, select *Orders* and then click *Next*.
5. Enter *18* as the field length. Leave the other options with their defaults. Click *Next*.
6. To make the field visible to all profiles, select the checkbox next to *Visible* and click *Next*.
7. Leave all the checkboxes in their default state and click *Save*. A new OrderDetails related list is added to the Order page layouts.

Go back to your order and refresh it.  In it's *related *tab, you should see the order line item details—they're clickable, too.

Step 5: UI cleanup

By default, you'll get the external ID and the url.  Not very helpful.  The magic of Salesforce Connect is that even though these objects don't live in Salesforce, just like we did earlier for the list view, admins can use the same setup tools they normally use.

From *Setup | Integrations | External Objects*, select *Orders*.
Click *Edit* under the only *Page Layout (Orders Layout)*
Click the Wrench on the *Order Details* related list
[Image: Screen Shot 2017-09-22 at 10.17.36 AM.png]Set your *Columns* like this
[Image: Screen Shot 2017-09-22 at 10.19.14 AM.png]Cilck *OK* on the modal, then *Save* at the top left of the Layout Editor.

Refresh your order again, and click on the *Related *tab.  

[If it still looks like the old related list, hit refresh a few times (that's a cache issue).]


Mobile

So that's pretty cool to be able to show all this ERP data in Salesforce.  But how many of you have access to your ERP data on your phone?  With Salesforce Connect and the free Salesforce mobile app, your ERP data is now mobile and in the context of the 360 degree view of your customer!

Here’s instructions for connecting the app to your org.
https://salesforce.quip.com/mNzHAD8wTczn

Tap the menu ≡ icon in the bottom right corner
Tap on *Accounts* and select an account
Tap on *Related* and then *Orders*

Your phone called Salesforce, which called the external service to get those details.

Closing

Congratulations, you're a database integration specialist!  

Salesforce Connect makes connecting to external systems easy, and lets you use normal features in Salesforce (layout editor, list views, related lists, filters, actions, relationships, reporting, chatter, even apex code!) on external data...no coding all that UI, *OR* trying to keep the data in sync and copying back and forth.  And it's on your phone!


