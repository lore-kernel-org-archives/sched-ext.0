Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A42236E0
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381239; cv=none; b=KoeB0cHwkgs+IuJfhegOeWEqJ/nElLhD0ktpWttIkuuCWgvjlZpSOwT3UT/nso4uHuENO5dBmOof0uad7xrl52vkTglsZIypSblOAnk5w6B4A3ZX3VuCOw0wOe/A8TqXTX15wHc/eyi4VFZ1Z6x4hMj9jy5PrvoI/T7NuDgU5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381239; c=relaxed/simple;
	bh=+oCBv7h30y0AQRxRYIIzBf7dC0+zlfV9v0sI4jwJFbY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=XnmpQzoAkLlELg9aJUhLZAaQsEGpfVTvK8uZ1P8LeauSm1mXdfZBAg+2I4XA2v1tn9Y7/XtxfyHiebNKwhnJuzsG5myPtoYmRupJHb7ihZVNUpCFYVFEOWdblYdseK0tG4sjgMzX/r4cMsrABMz2dyD99Gxw75p6Z8LjkyGF4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGdl8G9V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGdl8G9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21991F000E9;
	Mon,  6 Jul 2026 23:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381238;
	bh=+oCBv7h30y0AQRxRYIIzBf7dC0+zlfV9v0sI4jwJFbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LGdl8G9V0P3lj2kFvC4yTcFesiHURm5MqAodNQORUioAaaWrpAjAphQCuRi2xp3sm
	 9oaoZKUL/4Ak07J07zIYzieWPU2270tWLPKJticyXCeMrLEIop4J6XRMwzhSBduMbI
	 gUY3Tt6GawX1NWcOexD22iZG63qT3O76eKGw1+QrVZGjhSG3+yeRba4gvkARTekpI5
	 JuUpD21jQxPoJKKYICmmd1muhyGmYxggdXDXs5qc3SZQPM4JfvIxghU6NfxnPVdOhN
	 aQ2hPhp9epanag5MZdBAH30hDz599WGWIIX1UNcYvfDHonm3WTqG/iJMwxpfuXicz4
	 g1Tc6ozyIKfBw==
Date: Mon, 06 Jul 2026 13:40:37 -1000
Message-ID: <9112f6dac01fbc77fc9080376b6bff1e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 10/36] sched_ext: Add ops.init_cids() to finalize the cid layout before init
In-Reply-To: <20260706020817.2F1771F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-11-tj@kernel.org> <20260706020817.2F1771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 02:08:16 +0000, sashiko-bot wrote:
> - [High] `scx_bpf_cid_override()` failures are masked, leading to full enablement of a broken scheduler with corrupted CID layouts.

False positive. scx_bpf_cid_override() reports failure via scx_error(),
which aborts enable, not via a return value, so a bad override isn't masked -
the scheduler stays bypassed and the disable path hands its tasks back to the
parent/fair. The layout is also validate-then-apply.
