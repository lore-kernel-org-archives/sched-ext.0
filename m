Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E0A2A1B2;
	Thu, 16 Apr 2026 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362375; cv=none; b=aSxZvSptVofEk5cDmDDxHpZCQNutZHSO7R/HE0UMGNw3SlN+097dfqw6B+xDoM9hHE0kHXD3jXoe0r6+qyUT/XlRNoo78JaR3HvcXXmmNH/Sn/v2LQwEcueFS9xiXkx78coGOsyfOXiUU3D1EEtScMOZIi2Wam+gH/iMJ6aJdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362375; c=relaxed/simple;
	bh=DwFUOQieKU9C3mgInWP2wUqke/tOFn8NWajP3uqFULU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r54oxwlZASNyErSC8qbfp07eCwItMIWm9HpEdsTfpR/Yo6/q0RuLTja2te4XHhzksKkVAwSWvQewBmhfp8/NqfzH88W+7bwIdQNHEa+rv4L0pPe5Yz+zF+XlJ4Fyu6SQ18VrWpQ9a7RsTb2+xVJX71gQ6pNVr6Yodf87pc7/kF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR52oEoV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR52oEoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C4CC2BCAF;
	Thu, 16 Apr 2026 17:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362374;
	bh=DwFUOQieKU9C3mgInWP2wUqke/tOFn8NWajP3uqFULU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NR52oEoVcx7u5QyJSfYsiG389KrXus8UudAZRISYuBmK/By2/4la5OxAiCLZn75rx
	 Nf6FQds7ZyjpjRQNaeEuSk1/8NlAK6mDfoSknCPyXQZfRbyDhijwhn4RyIGsC6+qYj
	 CK+k+ertLsf4qqTXRgH6flfKCZTU75N4PDBzekBuhKmz2IAFRYcwxldk6KT7P5VOzd
	 uCHiGWCOTtm21kmbqXDuecHPfK0NWMjTeDhFBrRNedcbnQA7wonWumkZGBtB8wxz9t
	 0XMTrnjSm7/nfL9peNWbqI2Crg/mJj1RSeO+ep1Vkix/p9fh6kYSaB8dN4bJddqDPq
	 D1/pOFC5UqPJA==
Date: Thu, 16 Apr 2026 07:59:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Fredrik Bratberg <fredrik.b.bratberg@gmail.com>
Cc: Henrik Austad <henrik@austad.us>, Peter Ziljstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>, linux-rt-devel@lists.linux.dev,
	sched-ext@lists.linux.dev
Subject: Re: [RFC PATCH] sched: add CONFIG_SCHED_EXT_RT_EXPERIMENTAL to move
 SCHED_EXT above SCHED_RR/SCHED_FIFO
Message-ID: <aeEjhTftzK_sjYi-@slm.duckdns.org>
References: <20260414125933.3520885-1-fredrik.b.bratberg@gmail.com>
 <ad539mUd8A0lDWAw@slm.duckdns.org>
 <CALP2E1xwgfNmW+u=oyQ6bVW0ZeuQRZK65gR5RXyQyzy1n6U_8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALP2E1xwgfNmW+u=oyQ6bVW0ZeuQRZK65gR5RXyQyzy1n6U_8Q@mail.gmail.com>

Hello,

On Thu, Apr 16, 2026 at 10:11:16AM +0200, Fredrik Bratberg wrote:
> I understand that this patch undermines the safety aspects taken into the
> design of sched_ext: For example safely returning to the EEVDF scheduler
> if tasks are starved. However, this is a tradeoff which is fine for what I
> am trying to do, and the Kconfig is meant as an "expert" option.

I'm not sure we can include a Kconfig option in the upstream kernel that can
lead to system lockups in everyday scenarios no matter how the option is
marked.

> My goal here is to look into the possibility of creating custom real-time
> policies using sched_ext, where SCHED_EXT tasks could gain priority over
> all other tasks. I am aware that this pushes the boundaries of what
> sched_ext is meant to do, but want to start a discussion on whether this
> could in general be a future feature of sched_ext or not.

In the current form at least, I'm afraid this would have to be carried
outside the tree.

Thanks.

-- 
tejun
