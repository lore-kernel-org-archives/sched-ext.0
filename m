Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD67347503;
	Wed, 29 Apr 2026 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453048; cv=none; b=W8oE5LWAjQN8ZTzbDuN+lfuiAkvy6KTxvwq4Gpez/TzqaZ1jWSRzjndZT/PUSLx29YrZajNr8NOC/uE3cZVeHlNm9rBDcPSfRKHP0yrezmfzud/8K/Nt8RSrIcY8BSNJRSotmIPuW8rnqrLGhhZluLCX55XhB/KfLoii/6GxVO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453048; c=relaxed/simple;
	bh=iB2ZO3vVmyfGeopL6i2p7v5v3qIVwtk0DVbs2bGdJkw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=iiYa/qbnghBs8l+LB8ViO4xtoBDgovjt4vFJdQ3nW9qn+opIR6fbVgb6CDJq8h258N0zgd8/4oyC7Ubh3xfKNRqVdsaFwkvpscw148tWKjj0FP1AlWtXwLoDtVC3/9DA5X2SZvQhHOVXJWm2nAIyTf4xu1vxj7nvhZF2U05F19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXxdu/DZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXxdu/DZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB0FC2BCB3;
	Wed, 29 Apr 2026 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777453048;
	bh=iB2ZO3vVmyfGeopL6i2p7v5v3qIVwtk0DVbs2bGdJkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UXxdu/DZWMMoc4ow7WckKOt21VDVWS45L77IR5A6+i9ncuQGX8rzcAPBQKjJiVWUl
	 zKiirggPffurRE+5XpBNLBdor92eYwts+4OyTsFm4F6Ps8Ayr8HX8R1svV5wccLVF/
	 yWO6VeGubdarKTAKZfXUtGjPOjBuiYrzHZmQNyj57iF6ZkUfLZZx6LSzO8KvZxiLwn
	 ifG7LfU8K/JFrKK2hVzVRqOfhXbOCTMVP2mO6LEuHSyEqFtMxMOBvA7ATv6onSufjA
	 qH5EEWUuSKhoMXBvMB38EHw5urz3ZP7fAOHeeJRewvaux7z4ZJp2F5LZxTk5cQTX59
	 WuvWM+kGJiwNw==
Date: Tue, 28 Apr 2026 22:57:27 -1000
Message-ID: <e7cbfc99b52b4b7059267bb81498179f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: void@manifault.com,
 arighi@nvidia.com,
 kernel-dev@igalia.com,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] sched_ext: Improve exit-time diagnostics
In-Reply-To: <20260429082318.420146-1-changwoo@igalia.com>
References: <20260429082318.420146-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Changwoo Min (3):
>   sched_ext: Extract scx_dump_cpu() from scx_dump_state()
>   sched_ext: Dump the exit CPU first
>   sched_ext: Expose exit_cpu to BPF and userspace

Applied 1-3 to sched_ext/for-7.2, thank you.

A few things I noticed that might be worth a follow-up:

1. scx_rcu_cpu_stall() takes no cpu, so the captured exit_cpu ends
   up being the detector rather than the stalled one. We could
   probably plumb it through from print_other_cpu_stall(), where
   the stalled cpu is known.

2. scx_hardlockup_irq_workfn() already has the hung cpu locally, so
   passing it via __scx_exit() might be a bit more robust than
   relying on irq_work routing.

3. Minor: "on cpu N" (kernel) vs "on CPU N" (UEI) - the casing
   could probably match.

Thanks.

--
tejun
