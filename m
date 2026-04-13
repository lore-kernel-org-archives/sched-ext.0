Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FFD34B69C
	for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094181; cv=none; b=lr8eWhmY5yzTXu6N7+RP2w0I+ilKED6CzVyR8ApSKH6jvUGvpB56vJxvkqSsR4VG3UhjOpxsY7camr+HFe98/dn6Wmx7i6aEzPEaOBZaW+JQvAztDpDfcYCEOY+PPDNfLFB98RCDw6ltu3OQitQi2OOlJKJQQcOUqGb9g3uKufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094181; c=relaxed/simple;
	bh=NR+5k8ukR4ii0+m4gxeR5jAg+Hv8x71QJsfgETKlIxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=peP3/EdB8Mdn04LpY5bs306TIPnR/Opo3QPCmT+jjFlgdbipKUTBidpQ4vV5dsdkACAA5nMfFXFi/l9hIJnMJ4Hf7nHIy+zJHRZw2h7lfwn7F7D+PWo5SboUS8ToHBbyjBFB9ngy3CEDo2ECBvEgRYF/kYhtID0/DE3jACgc3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PF8JpLTL; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PF8JpLTL"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43d03065782so2741987f8f.0
        for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776094179; x=1776698979; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vlODL68AXkTrt/fDTHQFLWjjbdQAEDxlF+Jb+gRQnKU=;
        b=PF8JpLTLoCcB6BITcQ/qBnKStodoB0tBpN12+SsKsb0pOpTXij/2dd7OToagQNidrg
         +fUc3BGp2Kn68iLRgLTQFGafjrlkEWtArufeYFyArY6Hc0+BGD5W3OInjkK5bclDkeJV
         MIf1ZmvpNDBPvDaGEEpUo1haPFOw8KwQqjzAfbL6yFKZWeDavjCUEgCDh2uZEd5xFgzU
         rOyLaH0S1mvWPg15+9rjvIqt2pSW4UEQzZb0WaI5ou8Z/uN4Z95VG3gcJlgpKv14J3Di
         qiIHwDrZFIOyk67UXi7cx8BHKRJYMlbdjL5XZRXPNrghlxpRoYkrbaXhZoxqQDlje/Dh
         to2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776094179; x=1776698979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlODL68AXkTrt/fDTHQFLWjjbdQAEDxlF+Jb+gRQnKU=;
        b=HtBGHvPRSY0/WqXreAhLEj+aM3vTK2qUhMS6iy5NiIFnstTXFSRGbqIgCT5Sj9AvQD
         ZtFZKOHvEqLSFGaz50mrSLOhOSAGbrB4aemaxgrqoJf/xxZPr+t4d8Dlk2Rhp+k0bd9N
         PcXwO7/Bkfv8TMhjB4idxcOUSQcuv/fDZFeNNiNnoSabcTgqtPUic7emXdV8b4POJ6gd
         ZNmnu3YQ1Yr8BBAy2QWWIyDO/Vrk0zP3XiEq/G32qua6TFp+K3J8KueZ2mHIlmfag0up
         oIJuKj+GvxlUMTW+hjpakvnmdGi6XdAQIu0U5QnwuUrig8yjxESkYmAQQL0qu1XZmp2C
         AXag==
X-Forwarded-Encrypted: i=1; AFNElJ87yNLLymtubBQov/2VDf9hZxTk8QQXnC1+KLkrgZtUSwe7wxqOMMlpukD+ota6jAG5AwK6wfuRuVI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxifSBPmh2dRWBZLOLJ6L4rBJVuy7MyUE3dL8/hiOuTTPLKL1PV
	V962YKyV00cg7TbqeUDnfHBlI3qQb1uGi51vcHlRpiaUOcwwcy0Y3iZJc8HabgLIynMOa71GzV8
	k6Xo+6TWLo6Tfzw==
X-Received: from wrph7.prod.google.com ([2002:adf:f4c7:0:b0:43c:f4ee:7a69])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1884:b0:43d:778a:9698 with SMTP id ffacd0b85a97d-43d778a9a02mr7152422f8f.24.1776094178479;
 Mon, 13 Apr 2026 08:29:38 -0700 (PDT)
Date: Mon, 13 Apr 2026 15:29:37 +0000
In-Reply-To: <20260413110453.357198-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260413110453.357198-1-yphbchou0911@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DHS4U9BLRCPG.1S9E4BT1UIHQT@google.com>
Subject: Re: [PATCH] tools/sched_ext: Handle pinned tasks in scx_central
From: Kuba Piecuch <jpiecuch@google.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>, <sched-ext@lists.linux.dev>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Cheng-Yang,

On Mon Apr 13, 2026 at 11:04 AM UTC, Cheng-Yang Chou wrote:
> @@ -107,12 +113,13 @@ void BPF_STRUCT_OPS(central_enqueue, struct task_struct *p, u64 enq_flags)
>  	__sync_fetch_and_add(&nr_total, 1);
>  
>  	/*
> -	 * Push per-cpu kthreads at the head of local dsq's and preempt the
> -	 * corresponding CPU. This ensures that e.g. ksoftirqd isn't blocked
> -	 * behind other threads which is necessary for forward progress
> -	 * guarantee as we depend on the BPF timer which may run from ksoftirqd.
> +	 * Push tasks pinned to a single CPU at the head of local dsq's and
> +	 * preempt the corresponding CPU. This ensures that e.g. ksoftirqd
> +	 * isn't blocked behind other threads which is necessary for forward
> +	 * progress guarantee as we depend on the BPF timer which may run
> +	 * from ksoftirqd.
>  	 */
> -	if ((p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1) {
> +	if (p->nr_cpus_allowed == 1) {

If you want to cover all cases, then I think you should also check
is_migration_disabled(p). When a task disables migration, it is not reflected
in p->cpus_ptr or p->nr_cpus_allowed until the task is switched out (see
migrate_disable_switch()), which happens __after__ ops.enqueue().
So here, you could see p->nr_cpus_allowed > 1 even though the task has
migration disabled.

Thanks,
Kuba
