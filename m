Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB35212554;
	Fri, 13 Feb 2026 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770979220; cv=none; b=CgcVLDrzapoxhkAcGwuo4PamPBHw8SFKhDzUsFdACufwOP/1UnwjbBecb7VRXxSah1mRY0QIlbsfCh8TKaN/0dNeQSqror2rRL7oAPrKaYM7LuwRhtkFIu/0J4QPZBALyk7FEV/yMOnTs2ykMoXEEAgGHnRJl9oQ+HhuvWMOYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770979220; c=relaxed/simple;
	bh=wjW61QZ10cOrhbZlfyG4Qh5LOhsbteEfB728u9A7fcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3d92u1RGCCiv6FtPbETWNUOJ3QCrtclM0Nj50ZnIRXc2lpb19+C1z3vbDwa/nfY8h9iOBioS3vSE0PVDE+/kON8iYnH/PWgZ7wyrhvzH2E62aLNmfWr/3CZqhDId7U/MQVPQeIHQcFHhysqt/sa/Wl0D0iUM1E6AOgQJ8iMD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rn5JBYfr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rn5JBYfr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mr4WwEfHM9lsDpvP8bCsFh+L0GJ21etyDlQl4BSqcCs=; b=Rn5JBYfrZR6ciG2U/58/dfehK8
	zwuxEZHS5v4e7JbwjlbC7pmBZKdkVG74oL6l87tmg9YbjXY4Nlm+xfy53n1VN/EEvg136+HAuuTYJ
	Xioltl5JQT+v6ZAvLD67BXr+ZXPXVLzg3jqptPdBX+XZD/d0q9VFkYt2GxhUjXL0TgLzmv1YNtpdP
	0uFglwqGxJ5qooDTSxI7weWtPR5mtE5yAWVOaeot1sTuEJMJCthio/rkN51aGapI1ZL8VMB5y8N02
	lehvZjaypi/7kiMRzF9OkaX5PqceQ7f6X6p7fG4eqzqHbxd8TvdQDNeBQu5KfUaWfBPaV95srYK10
	NyRXqYNg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqqaq-0000000C64V-33dK;
	Fri, 13 Feb 2026 10:40:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 769793007B5; Fri, 13 Feb 2026 11:40:06 +0100 (CET)
Date: Fri, 13 Feb 2026 11:40:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, sched-ext@lists.linux.dev,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [linus:master] [sched/core]  704069649b:
 kernel-selftests.kvm.hardware_disable_test.fail
Message-ID: <20260213104006.GK3016024@noisy.programming.kicks-ass.net>
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
> 
> commit: 704069649b5bfb7bf1fe32c0281fe9036806a59a ("sched/core: Rework sched_class::wakeup_preempt() and rq_modified_*()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 

So this commit has been in tip (and thus -next) since 17 Dev '25. How
come this is only reported now?

Anyway, let me see if I can manage to build the kvm selftests today
(last time I tried it was an utter trainwreck).
