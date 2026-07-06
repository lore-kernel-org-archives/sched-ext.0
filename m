Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D23BFAD1
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381249; cv=none; b=Euo5PYe4rPdLaoVCyoSE3aosGP2Jjdqfd9/SjiJWlHbO7H9rWaSrILaIOvwJIPy8i1M5NscRtVm6c0awFl25NW8uHbsp9C5Lxd84XTM88fkLGAiyhV9eNPXZyXMdx7oWevYzgEKNgJXi5r5/6M8t/gJHrzZfULSm9S6JAKL9gRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381249; c=relaxed/simple;
	bh=VnPLcosUfDzc3+L694yGGqzxIH7uZAuIPNgTDUZokpI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=NLma+KGpcYa9GhJST4k1vSBHTK7YV+L0116AaSNzxJmWouANm9L3xAevPdFxVcbKbd4GeKtl/357uaYZ0hmQrk/3Tsx9E2REqJDUW7E2RwE31yN26VstE14mzYxMcuy2ie7ylcj1n8GkrTWI1uH8u+I/wIqF/7jiVRqsEUfRjRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu4DTzHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu4DTzHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72471F000E9;
	Mon,  6 Jul 2026 23:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381248;
	bh=VnPLcosUfDzc3+L694yGGqzxIH7uZAuIPNgTDUZokpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nu4DTzHtOkFwMsibNTECRd/Bc/i/H6gPDRJQ255zJNWQZbXo01O1qvLmxXbulZ8GF
	 x1cYwBo3Wp8JTY+V8kY1fhryVuWkC7bmKx/69Ir8/aRb9W+mo0aY7LKL3zSVKVSTdI
	 MaSZ5tEXBHAo4rUbr1HtfZGXfpdozsi7q/ffhtrFKjIBMIzqmOK+ZImlJLh6v/Ch6n
	 WPMS6Hz0dNWbY9k6kZF4zscJca/rCwhZcV88XXEM1io2mjveWQkHOs6GdSqknVgKvu
	 Ti4sTYy2yr5DKTvgmbSC5N+93/zW7ILhTpbrDR+7TSjQd2oZ8yve5kh6Ho6O4n7cW6
	 kx4SzQG4xuvsQ==
Date: Mon, 06 Jul 2026 13:40:47 -1000
Message-ID: <e2b74eabb5762d0d34ed5d3fd637d721@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 24/36] sched_ext: Add reject DSQ for cap-rejected dispatches
In-Reply-To: <20260706020851.660721F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-25-tj@kernel.org> <20260706020851.660721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 02:08:49 +0000, sashiko-bot wrote:
> - [Critical] Kernel-forced bypass to the local DSQ on offline CPUs interacts with capability rejection to create an unrecoverable infinite scheduling loop.
> - [High] Unbounded task re-rejection in `scx_reenq_reject()` creates a hardirq storm that can starve the stall watchdog and deadlock the system.
> - [Medium] Missing `p->migration_pending` bypass in `scx_local_or_reject_dsq()` leads to spurious rejections and stranded migrating tasks.

24-1 (offline) and 24-3 (migration_pending): confirmed, fixed for v3.
scx_local_or_reject_dsq() now force-admits to the local DSQ when the rq is
offline or the task is migration-disabled/migration_pending, so there's no
reject-DSQ bounce or WARN.

24-2 (unbounded re-reject storm): false positive. runnable_at is preserved
across re-enqueue, so the task ages and the stall watchdog fires and bypasses,
breaking the loop. The re-enqueue is bounded and the storm is intentional.
