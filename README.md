# oldFaithful

Description: Cleaning data entered from the Old Faithful Visitor Center Logs from 2001 so that they're ready for public consumption.  My purpose was to prepare a new dataset to use for clustering algorithm examples, since there are some older and very famous Old Faithful datasets, but which are much smaller (e.g. Azzalini, A. and Bowman, A. W. 1990, Härdle, W 1991), around 300 entries.  This record from the year 2001 has almost 1500 entries.

Procedure: I found the information in a tab-delimited (but messy) text file [here](http://www.geyserstudy.org/ofvclogs.aspx).  I fed it through excel to do some automatic conversions via Excel's Text Wizard.  Then I brought it into R, where I removed the surrounding text, removed a lot of the mess, and computed the values found in the older Old Faithful datasets: the waiting time between eruptions, and the length of the eruptions.

I intend to use the data in something I'm writing as a dataset that we can apply parametric, k-centres, and density-based algorithms to.
