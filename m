Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD57431E75;
	Wed,  1 Jul 2026 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935227; cv=none; b=UP8olNz60SEjVu482dOpAYQhSxNw0SUQTasPYP1eIxZfKkslfaBQn+iiiXGqt2NzKJpJCZ3mqRwbWK6rWeHIhZLzb4cRkNhgsxBTQem3vwiaYkWKqRz4tHNQz+e6/orz+3sbpv2KXn5oAduxey4+TYTSNcn9bUARBKhkOYNdR1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935227; c=relaxed/simple;
	bh=K5nPz+S8dTzix7vmF6H4+wNFDX5RKW0GvnEan2Qtokc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ucAts0uM2PaS/YQ0+bmNJ3raCaixsFLV9iYOv+GDdHHGbHiXY4CeQDwiLbhbTri75j5PpXGYSmhA3brWBszhr34xFvY9Z3QTqqtSGgLLbtj0YDVGCUthEyVItc5yEoBN7kAE4x2f0hEYpgyFMRhsOifqUMj/FOTDzCDL9Rghzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAPsvews; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAPsvews"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622091F000E9;
	Wed,  1 Jul 2026 19:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935226;
	bh=K5nPz+S8dTzix7vmF6H4+wNFDX5RKW0GvnEan2Qtokc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KAPsvewsvP5jWJHd0rwheXOBo+TCxBdtorE3is2YAcmxSk6oM4MiUV0e2SGpTYUe8
	 xLu1Z9375sZOU0yRsx0s9zSQJBksV2Zse9k0ptQ9UgXNB/36WZKJCQcoGn+zUm9fcE
	 lUXSjUiNQ9hHHyp9jp17NF/PL5/DmQlROG1izk0bpvWchHzMGasnbpJ8n4ibEKvbW0
	 Y0u3W5BZaWFjA3IBrZgiR2m4afVNhlCzoi3iFBZ3Ie4OIVHeR/ZTh+A64yKKH5Qhoa
	 csI6K7aBjz8d/kyHo/Iuecr0Ov0QgmvEam39BJSaQ3oL5vR3RaDUN9gGP7aSxqqYl7
	 oLnlt/VbBoS0g==
Date: Wed, 01 Jul 2026 09:47:05 -1000
Message-ID: <602f4cda8f1891a43412a5a304f9c690@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 4/4] sched_ext: Split sub-scheduler implementation into sub.c
In-Reply-To: <20260701183424.BAF9A1F00A3A@smtp.kernel.org>
References: <20260701181046.2490390-1-tj@kernel.org>
 <20260701181046.2490390-5-tj@kernel.org>
 <20260701183424.BAF9A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> - [Low] Compilation failure due to implicit function declarations in `sub.h`.

Yeah, scx_dispatch_sched() moved into sub.h calls three ext.c statics whose
declarations only land in a later patch, so 4/4 doesn't build on its own.
Another series-slicing mistake on my end. Will fix and post v3.

> - [High] The `scx_bpf_sub_dispatch` kfunc breaks runqueue lock atomicity for the parent BPF program.

ops.dispatch has never held the rq lock across its whole execution, and
scx_bpf_dsq_move_to_local() already drops and reacquires it when consuming a
remote task, so there's no continuous-lock guarantee to break.

> - [High] Missing `scx_error()` calls in `scx_sub_enable_workfn()` lead to silent sub-scheduler initialization failures and zombie states.

This will be addressed in a future patch.

Thanks.

--
tejun
