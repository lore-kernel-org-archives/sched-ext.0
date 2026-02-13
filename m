Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF43361DC6;
	Fri, 13 Feb 2026 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993863; cv=none; b=rWKxbXtW7BjfYgl+RMp69rvPubESkU0iXwrOWjWqlinLXG7WDw993/4mjlaWVqcOTf1WAIjuNBxUSY/rAo/GqaByfycu39iOrr4IxkgmT0bCiqHdvGbPbrqmS1WGv9mYidUOGcC7STQftlJG9/N9IbG5MmTVoo9R5xGWl3jOVDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993863; c=relaxed/simple;
	bh=wLtd2pBfF/CTfQbKzki+RTx9MUHP1T4aEpmK58jNVdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+llbVhc/Tz6geAYmLgzbYYHpnVzD5yaUZ/qczcvbKnay6Zu4BIGuisM5qBNkINaQMSbVJ3SS3efTstgr5/CeLIDRzOK9MeP61rgaKIYnapQSRSULs0p7DecwGgUxe+OpOLVZ1r9hZqNffs1eYLZXW5prFQ5Pe5trlfgVvAOrfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CJMpEp0+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CJMpEp0+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JMdfy0G0kNrWOJNK0peDie9awe+REYGwQ96ealWZpl4=; b=CJMpEp0+8AHlqo3bZ1dHoqRqeT
	Xb/WNqNdH4IcQaMS8c+F6TpK1pvtEGHjoKjHtgkl9fufbZgtOY8pWZno+N7SHyzTwIONsUV8CuBRr
	4qpNbD9WogAMgf+X/X1u6wnPuInyvc6HWTYD2dNUB5XVENec40Gvbh2FA+e4f1r6Pqumx82ZdMyPQ
	Ahf7QQa8dCTFWW+JWAmp7Bkh+NNz3rUl0pIr6+ALOvgBwAlOeq03cS9CipmmP/bWh/8WNEX/2B0TJ
	761mNo7rRtO5Eefuxzg08BNZ4U90MaVmw110CvJKzed0j1mmPDYDh3bigdZ7bSVpGpfi3wCvvXatC
	vWYShuDg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vquP4-0000000Fr7r-1GIC;
	Fri, 13 Feb 2026 14:44:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DE97F300969; Fri, 13 Feb 2026 15:44:17 +0100 (CET)
Date: Fri, 13 Feb 2026 15:44:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>,
	Sean Christopherson <seanjc@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, sched-ext@lists.linux.dev,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [linus:master] [sched/core]  704069649b:
 kernel-selftests.kvm.hardware_disable_test.fail
Message-ID: <20260213144417.GL3016024@noisy.programming.kicks-ass.net>
References: <202602122157.4e861298-lkp@intel.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202602122157.4e861298-lkp@intel.com>

On Thu, Feb 12, 2026 at 10:08:04PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> we found the kernel-selftests.kvm.hardware_disable_test failed consistently upon
> this commit but pass on parent. unfortunately, we didn't find many useful
> information in dmesg. this report is just FYI what we observed in our tests.
> 
> 
> 
> kernel test robot noticed "kernel-selftests.kvm.hardware_disable_test.fail" on:

With the caveat of PEBKAC (it is Friday after all); I can't reproduce.

That is, ./hardware_disable_test as build from cee73b1e840c, doesn't
work for me on 704069649b5b^1 either.

Sean; is there a magic trick to operating that test, or is it a known
trouble spot?

> 
> commit: 704069649b5bfb7bf1fe32c0281fe9036806a59a ("sched/core: Rework sched_class::wakeup_preempt() and rq_modified_*()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-05f7e89ab973-1_20260208
> with following parameters:
> 
> 	group: kvm
> 
> 
> 
> config: x86_64-rhel-9.4-kselftests
> compiler: gcc-14
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202602122157.4e861298-lkp@intel.com
> 
> 
> 
> # timeout set to 120
> # selftests: kvm: hardware_disable_test
> # Random seed: 0x6b8b4567
> #
> not ok 85 selftests: kvm: hardware_disable_test # TIMEOUT 120 seconds
> /bin/sh: 50: cannot create : Directory nonexistent
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260212/202602122157.4e861298-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
