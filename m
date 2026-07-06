Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623D3BFAD1
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381244; cv=none; b=Zr+4pgRwD+O0WgsbXePHxsAlgj4efdjt2e5L/f620DZRlUU1bsCRGkIbelQR83SZFLVqcs5Fd+C/N+DY4L8W1Hg0197ytQWZAa7dsICYwDH8SylpdhQ7POurkC0eBgE/8KwyWMlUqxw3brupc0y1/je4QrVkBSHY9SAnDGMEXRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381244; c=relaxed/simple;
	bh=Zn2j4kZ7DFlkkxyiCeCQzt2VtHBo/dtlg5d2hK4f3XA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=DdThJDJDKeB1ciBNCleDmjWDbuR8m1C3lh/Zi8A7GFSb8t8L59yVxmAmp11Xk0n7AlJrQEOmBOndRXRIIBki6/fy7YDVsFxTe9DBmGYM2qvwDRT+1ZHUN8p/3ByOELakCHfGJDwZRe42cv+EDJZG7TrtBEu9hZa15PkLD+d3QmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kw4TBBTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kw4TBBTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86531F00A3A;
	Mon,  6 Jul 2026 23:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381243;
	bh=Zn2j4kZ7DFlkkxyiCeCQzt2VtHBo/dtlg5d2hK4f3XA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Kw4TBBTK/B6GMEreDTajP/6Ea+KpDt8ANU1KsTj1houRaIvwUxLsXX3PzVvH7j/q5
	 gB+tf2RVtqxEoL+XTl/oGKYYoeQlA+3mcmQh0Az/x86u0Sa82qeUFW88wc/oSbB6JJ
	 5WH39/Q46UrWR60A2uOx4fU3iG6Ig7iquAAaYt+2xNyCjzOJs0VGBzSCRthPd2K4+8
	 DYNEwjNHiJmKJ8AEai9ChdamglwTMwf4izjaCtEQwN6dao6OKcbhcjjrXQfQYpmWqv
	 FaEZJhsJzuUgWDOdECp8qfTB+YQZBlRZcqWA9TVpXCweVB2ghkFfCsxKyMcyJyiokV
	 3f+AjDqigA5mw==
Date: Mon, 06 Jul 2026 13:40:42 -1000
Message-ID: <ecef28b2d5677149e2a5ce187e2dcd86@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 17/36] sched_ext: RCU-protect the sub-sched tree's children/sibling lists
In-Reply-To: <20260706020810.BA8621F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-18-tj@kernel.org> <20260706020810.BA8621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 02:08:10 +0000, sashiko-bot wrote:
> - [High] Incomplete inheritance of bypass state in scx_link_sched() leaves the new sub-scheduler in a broken bypass mode.
> - [High] RCU-001: Remove Before Reclaim Ordering Violation in scheduler disable paths.

17-1 (bypass inherit): fixed for v3. Instead of inheriting bypass_depth
(which the per-cpu bypass flag never actually sets), scx_link_sched() now
rejects linking under a bypassing ancestor with -EBUSY.

17-2 (remove-before-reclaim): false positive. @sch and its pshards are freed
by scx_sched_free_rcu_work() (call_rcu, a full grace period after
list_del_rcu), and no walker calls a BPF op on a dying sub. The ordering is
fine, not a UAF.
