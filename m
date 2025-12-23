Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160A1D63D1;
	Tue, 23 Dec 2025 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766457862; cv=none; b=so8Y0FsQhSJt5vfezlGddyB/Yh7OLduVxlAJ1rM2ap22VHHswQCJMLHbICHau+kus7TzDYB4URNjQSuuYq2drDloCvr/LGqWZmh1eYvDKVli8i79J/PV+XIkf4ObM5nQJ0nTUFNxdVyVC+EZr0myfV++DXE0FYEih5O6VhY4XUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766457862; c=relaxed/simple;
	bh=UnfdpqbG4ruAU2BQghW9d9gN0Et7WG0mnTZ98BYp8MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebWgMj22Erz5OIhS50gIq7rNQ5mhQW8qrQB2tj8bEHkfXpnqooD72KrcneBrrZTpYLhji9IZWlNC04TFg5aVcMm9+m4wUkFecFZv29j4b+e2HKGxmGFcxmA2RaKRlgQC5rvxdqgkt/8rz1EZalz2dqe8kr4DHIKYIUIEvMW5eOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVIPYz1x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVIPYz1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EA4C4CEF1;
	Tue, 23 Dec 2025 02:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766457862;
	bh=UnfdpqbG4ruAU2BQghW9d9gN0Et7WG0mnTZ98BYp8MA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVIPYz1x17PT9Uy4Ui1mZ8LTeQf0Y2583clI/opCueKjwHdK7e4z5zVPpJoTEIsrg
	 I99YXG/1Wogl+ZbJoKvkusaq3TCVfj/gnnpb9dzO0I6txF3CF1fnZGpf6J/bq6bczR
	 XJdDP1VENd+mnRD55VtFZ8tJa4R4CZfutflkJdKd63HPc9/AKDYQyoU22dlfaAvs6X
	 6oCAs8KRTh7izuhiwbGO17aXkrYuTdsDuzulNO7T5co9T3YDO41CUtySjYmXpbc9FQ
	 kZgFyG4LCkxIF9J8p7x+Ufbf/JDqGfcdR/9GA6xYTMfMnUlHNheHhg9K4PBEi3IaVn
	 rpPFaBRJlCNIQ==
Date: Mon, 22 Dec 2025 16:44:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev
Subject: Re: [RFT] sched_ext: Skip stack trace capture in NMI context
Message-ID: <aUoCBVhHig737uKt@slm.duckdns.org>
References: <20251223005038.62406-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223005038.62406-1-joelagnelf@nvidia.com>

Hello,

On Mon, Dec 22, 2025 at 07:50:37PM -0500, Joel Fernandes wrote:
> stack_trace_save() is not guaranteed to be NMI-safe on all
> architectures.
> 
> The hardlockup detector calls into sched_ext via the following call
> chain when an NMI occurs:
> 
>   watchdog_overflow_callback()
>     watchdog_hardlockup_check()
>       scx_hardlockup()
>         stack_trace_save()
> 
> Skip stack trace capture when in_nmi() returns true to prevent
> potential deadlocks.
> 
> Fixes: 582f700e1bdc ("sched_ext: Hook up hardlockup detector")
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

This does work on x86 (right?) and is useful in understanding what the
underlying problem is. It'd be great if there's a config flag we can test
but if not can we specifically exclude archs which are known to not work?

Thanks.

-- 
tejun
