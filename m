Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E33A5437
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381256; cv=none; b=BSEaiBRZy++f0A6RaNwIWKcrSciGQmG5PdCqldBtoq8FTpOo8orMd/Y8iTCNO6Jmo7h5Lvq9svgQW3J+Ld9m6iGvs6Wohm3+8f1Xwt2scZbLIKlPNA8cBvVb0Ya9P0LbcYozEQ4raeXiUh6deMSfkx5PEBxiirLiJDVuyv9WQkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381256; c=relaxed/simple;
	bh=E1IfkSlW13kCaBfnS7BBYVl0qH4NAXyEsegmPtWxfYE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=mgRC++XwGuEheDQ2jMDSJIUUjKaIbzy4Sdik2mGZGTZfLJQZKmUpQ8yWVXqes2Bbjwg1pJ7GHWz1iJM53lWSYrjSg0Ca0cocVN0chVy6MzDjMwqQhh/6fKQMqo0dVAZkqtGtFmTnBpGAWzqNTlQtgkTExBGaBxYxyn0bXCJt6oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQtJElpP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQtJElpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15BA1F00A3A;
	Mon,  6 Jul 2026 23:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381255;
	bh=E1IfkSlW13kCaBfnS7BBYVl0qH4NAXyEsegmPtWxfYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YQtJElpP1st7V6fFPLe/6ayESYhyWcFeLrr7mgwuVmMhl8UBkDY472aPnluNZ2xsp
	 1s5Y5MSCuWjvu5BrS77h91LXVcf3at73KCgeYHIAN1fSjHSR4VgMHvsyENlPr5f9sd
	 JeOJKXXuVdx3Rn52K/6XsznyNY+Zlh9FEKA9YT97fiki2lBvIOlQFofwprNKwW6srD
	 Pw/Vt9TDszF38pUaz1FMjfUY0xJlH99yos2eCYm+736ONGU3grqRfQhNXAp1cpXMBg
	 pK0Qan1lJbfaskr58xwSq0DJoA+Aw9bRASisD6cIaGN8QJX1aMq7UO+RVaCWNdfVTa
	 Wu7nakibr2BJQ==
Date: Mon, 06 Jul 2026 13:40:54 -1000
Message-ID: <ff646a2c7414dd83e8c590d12a8b7606@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 35/36] tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling
In-Reply-To: <20260706021014.BEB9F1F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-36-tj@kernel.org> <20260706021014.BEB9F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 02:10:12 +0000, sashiko-bot wrote:
> - [High] Tasks dispatched to time-shared CIDs via `qmap_dispatch` lack the required `SCX_ENQ_IMMED` flag, causing the kernel to reject them and trigger an infinite bounce loop.
> - [High] Concurrent modifications to `qa.sub_sched_ctxs[i].cgroup_id` during attach/detach race with `compute_partition()`, causing `nr_shared` to wrap negative or overflow `MAX_PARTS` and triggering a fatal `scx_bpf_error()` crash.
> - [Medium] In `redistribute()`, elapsed time is incorrectly charged to the newly computed partition layout rather than the outgoing one, resulting in corrupt allocation statistics.

All three confirmed, fixed for v3 (scx_qmap demo): dispatch-path moves now
pass SCX_ENQ_IMMED; redistribute() charges elapsed time before recomputing the
partition; and compute_partition() snapshots the membership and weights so a
concurrent attach/detach can't drive nr_shared negative.
