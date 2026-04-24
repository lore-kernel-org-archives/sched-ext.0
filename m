Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A6A2CCB9;
	Fri, 24 Apr 2026 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051799; cv=none; b=WBBnPSchvnl0gUDAPyOkIlgS02fnl5Z/S+HMWeQnl5OuDHTAZ0XAuJi2l2S9yCFVxmdinm1S5CcS7yzaO0qKdmYjYODj4eYKjjhOfZGOVcY+0h/hekr04fToj4K49GTXkVniTEMys271XJw8eOReln90UEquBcMRag+Nf8oGrbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051799; c=relaxed/simple;
	bh=jTOj0Rm2YgkrX7ekA/U+WwY+btp+Sgf4GT1E4v8oTLk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ClCgN67mvUEHof7j64jddecNdOBYGtfybm4+j28taqZTaBwvmcJ9eLS9U7LDG7VhiBKofWucx9bdCT3Yv/SdO9akOk08LHEN7ilVM0PoZXrZTp5ka2jOzC+iaXjo3R1Sp4n+f3WgwZ5V6pJQ01DZYvPbTQ8C8viA34AeyX5qhNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww6IjXYp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww6IjXYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEB0C2BCB7;
	Fri, 24 Apr 2026 17:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051799;
	bh=jTOj0Rm2YgkrX7ekA/U+WwY+btp+Sgf4GT1E4v8oTLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ww6IjXYpYEpKPczVHJm9Igvhv4JuRmzK9k7deYG9wRj4i72lXaHA1Lu5a7pVftYnT
	 0vLX1OKw5rg+/wUH7SeXMc6oYP5oEyFry8Og3Q2qnI3TFV/I6bu5prehL5eBMbCkDQ
	 dlyjaGl6WhLwUhvFKPgxRC6iLfim04ZHcuPAFLS1IgcOHNQkuwmJr++Y4+n+XMu7YH
	 RMZZebEjvX45jWqU4H3/PaGvQEJXSAjObOEWCCRI+Ho/qveRRb9iI10+lbM8Dpy7mo
	 om9Vlcu9o23lrptnyMvRDepW8CYAMCuLwmlO0npy8OsyAUQRyPlyKFd6rnb5/Gof7Y
	 mriCRCaMtkDMw==
Date: Fri, 24 Apr 2026 07:29:58 -1000
Message-ID: <cde4cfac70163b928e007ba66c45ccb0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yphbchou0911@gmail.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	jserv@ccns.ncku.edu.tw,
	chia7712@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH v2] sched_ext: sync disable_irq_work in bpf_scx_unreg()
In-Reply-To: <20260424100221.32407-1-icheng@nvidia.com>
References: <20260424100221.32407-1-icheng@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Fri, Apr 24, 2026 at 06:02:21PM +0800, Richard Cheng wrote:
> [PATCH v2] sched_ext: sync disable_irq_work in bpf_scx_unreg()

Applied to sched_ext/for-7.1-fixes.

Thanks.

-- 
tejun
