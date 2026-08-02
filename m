Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F283368A2;
	Sun,  2 Aug 2026 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785700308; cv=none; b=EFxT+zR39bGnZPhpN4+JNxBYSdRBVREs4+zgeIiVGBu/XEnJC3Jm3hLFfQipoSOT0W7Q1dQm5S2/2dKa6j/lhLhzYGB45gTadEqnvuPmBVEgc2Hx80blZuXJd6GBqqJij3J/i7KDvW+5iPKV87+HD/uyRO/qgvN8L3u2z5egE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785700308; c=relaxed/simple;
	bh=dZ7OFfi9eF/jIWoS8fdkKKbzbRf0Q5uDnCjryE23lFo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=R9UWBEptkQN3XWxm5sVM3d2FBpy1c2zYvMu42QiRDUwhJD/vSo/sVctR59GUpgFNkac1ptkrS7RoSGHN/eNTA/zxTreS/hhExBN97T5Jo8T8MPFXrVVtEv0xIcnPY9wheWwigkeR/cQs1uHTKCVDKyEAZwYIn7H2r80XqvnrBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ1zlQ/Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ1zlQ/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41C71F00A3D;
	Sun,  2 Aug 2026 19:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785700306;
	bh=dZ7OFfi9eF/jIWoS8fdkKKbzbRf0Q5uDnCjryE23lFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eJ1zlQ/QnxKCicr1sKvibjYV1i7AZ7WroQsWrAYqNn/SVfg7B/QwxxfIJrlYAptT5
	 glME0wbRL8Zy04BJY48Se6YE/Dmc5mpWhLqQofYGf7Zofn/acC7XHbZ5n2KkOZfxhl
	 8bCPh0A9AyrmQr+89MAMpp992V2jAUcRRXIh2cXa6hJr0zoNprBQlgqX9zNm/IIFAP
	 bYJCM4I419W6hlw2aigLRmbQqthF0G+yx1Tn5Y7uWxRHaFXErbrMAIrJzI7XEbWVvf
	 k41p4bs5ivfoC5S/W/NkxWCet2dYHFTotfLcHj/zoD5sW9PK5sm8DtZE05FPZne7UL
	 5qdoLoLWf305w==
Date: Sun, 02 Aug 2026 09:51:45 -1000
Message-ID: <53990ac674de2b3dfcec0fb18168a5ab@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH 12/12] sched_ext: scx_qmap - Add rescue support
In-Reply-To: <20260801090603.593D51F00AC4@smtp.kernel.org>
References: <20260801085150.2697653-13-tj@kernel.org> <20260801090603.593D51F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Sat, Aug 01, 2026 at 09:06:02AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does removing the !(enq_flags & SCX_ENQ_REENQ) check here cause an
> infinite bounce loop when rescue is disabled kernel-side?
>
> If scx_qmap is executed with -B 0, the kernel capability check rejects the
> insert and bounces the task back to ops.enqueue() with the SCX_ENQ_REENQ
> flag.
>
> Without the check for SCX_ENQ_REENQ, qmap_enqueue() will immediately hit
> this condition again and force-insert the task back to the target CPU.
>
> Could this lead to an endless, unthrottled loop that locks up the core?

The loop is bounded. Each bounce goes back through scx_do_enqueue_task()
which counts it in p->scx.reenq_cnt, and crossing SCX_REENQ_MAX_REPEAT
ejects the owning scheduler. With -B 0, a stranded task takes down qmap
instead of starving or burning the CPU, which is the intended failure mode
when rescue is turned off.

Thanks.

--
tejun
