Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E933CEB4;
	Wed, 18 Feb 2026 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771407665; cv=none; b=hEFnWCkIcmcIO8fgNI+swnxqa9amgG9VZEAl0rXk3yHZiJbBAHlp9e78oWd+py6J3p2aWC2/KS/tm+5IkOdL0N1QSigd3cY30Bpg5jpI9HMJPA4tiOV5anWUagN4pESuRFnAwyK1FNI51ut2z5oJ6U8htSQgpoeTDQRjHIoTolc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771407665; c=relaxed/simple;
	bh=NDFJbk/BFwqHVibRykzi/FgFqV0F/XEySGpaSVYH6KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCrPvGpl3uy/c5+XtN0KoNAcSopoZnHDVCeup2bP1AZb9qqiuqUW4wRw1pGG1uxhZoIYEHQ6ml+WF41NCUrqpG+tfqMvNktVtn+bYbKh6oZWAv1zQdJpvW9UKPY01UYZc9QWyMd+79VXgQKX7XP7m/PlIlfcU11nri2BjHGmwI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y+gnN5g9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y+gnN5g9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lBwtclkQaCgMpl8CdrtjyAqZW8zWsY/Zj7WJgl0YaFk=; b=Y+gnN5g9BP1HlrJDN9aNVNepS3
	XHvXHu0UW+yDKqpCv2ZnWtUUsyvw+WOqiGp9KMO4/AAUCr+s+i3JtjfxvqB5CVeXifIUPNyKaR2tx
	ZEHXki0tRJCT+Zh+MrdaHUX2xZxRrUocec1JfSRY2wUEA/HwFcB8cByBu1gl+gWdi2fF5U6uOkmnF
	NM1EqeTXeLJkAL5bJcCVsA7TcBWlOqQsr//PdPHZD2Ay8mY8h91ONSpdwlBQhcbDpUen3pT8yCNrj
	Yk8g/F/OpA0MfirgQhSJL0nqUn3/wXOCXo0oEBjxvOK6Mr75agzoGJvz/mArgrDCjG5XnCLBGrNU6
	WtipYRrw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vse3D-00000005pMO-0i9o;
	Wed, 18 Feb 2026 09:40:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CCF2F3004AB; Wed, 18 Feb 2026 10:40:53 +0100 (CET)
Date: Wed, 18 Feb 2026 10:40:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, sched-ext@lists.linux.dev,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [linus:master] [sched/core]  704069649b:
 kernel-selftests.kvm.hardware_disable_test.fail
Message-ID: <20260218094053.GD2995752@noisy.programming.kicks-ass.net>
References: <202602122157.4e861298-lkp@intel.com>
 <20260213144417.GL3016024@noisy.programming.kicks-ass.net>
 <aY-iNnrhEj2XuRcH@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY-iNnrhEj2XuRcH@google.com>

On Fri, Feb 13, 2026 at 02:14:14PM -0800, Sean Christopherson wrote:
> On Fri, Feb 13, 2026, Peter Zijlstra wrote:
> > On Thu, Feb 12, 2026 at 10:08:04PM +0800, kernel test robot wrote:
> > > Hello,
> > > 
> > > we found the kernel-selftests.kvm.hardware_disable_test failed consistently upon
> > > this commit but pass on parent. unfortunately, we didn't find many useful
> > > information in dmesg. this report is just FYI what we observed in our tests.
> > > 
> > > kernel test robot noticed "kernel-selftests.kvm.hardware_disable_test.fail" on:
> > 
> > With the caveat of PEBKAC (it is Friday after all); I can't reproduce.

PEBCAK indeed, I managed to consistently boot into the bad kernel :-(
So never actually tested the good one.

> > That is, ./hardware_disable_test as build from cee73b1e840c, doesn't
> > work for me on 704069649b5b^1 either.
> > 
> > Sean; is there a magic trick to operating that test, or is it a known
> > trouble spot?
> 
> Hmm, shouldn't require any magic, and hasn't been known to be flaky.
> 
> This very decisively points at 704069649b5b ("sched/core: Rework
> sched_class::wakeup_preempt() and rq_modified_*()"). on my end as well.  With
> that commit reverted, the below runs in ~40ms total.  With 704069649b5b present,
> the test constantly stalls for multiple seconds at sem_timedwait().
> 
> AFAICT, the key is to have the busy_loop() pthread affined to the same CPU as
> its parent.  The KVM pieces of the selftest have nothing to do with the failure.
> 
> Here's a minimal reproducer that you can build without selftests goo :-)
> E.g. `gcc -pthread -o busy busy.c` should work.

Whee, thanks! OK, let me go prod at this with something sharp, see what
falls out.
