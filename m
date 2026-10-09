Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655DC4A7CA0
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554664; cv=pass; b=dAtuZB8veD0nNjvDOKiWYvHuZQFmr8HaybimL5YRWzvUXrLFnu254Wr52+eSNGoZEOZusUTjizU0tsKFQlgJrtNAaXFzU0NuN9Zj4LJvnhlV4kpAmdwUaCtXWAhMPzVs81A6VYyUSWKdeLB7V14nCVCvb8Wr3zDTGnUSqvXx8Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554664; c=relaxed/simple;
	bh=+HnSit/5/uIBAXvpoT34XbcMxm0QUvBctmOU9VDQG8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGxSt3UNxXusIHkjKQMzR9gGEl2SwPbGw9UC1Unw0OEiulS8hdp6ao/xniHhTEnzvSRSQb8y0indMWz2au4qmxJCCtWjT6MJiiyenUuJv5+TREfQqGMzTZtNRnT73WL8PrGDqIFXJ9z+UP+inKcXwmlG92v2L4UbZEmdphz8vvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VlxLAYwb; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VlxLAYwb"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c20ce3c118aso376341666b.0
        for <sched-ext@lists.linux.dev>; Fri, 09 Oct 2026 07:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791554662; cv=none;
        d=google.com; s=arc-20260327;
        b=frD2P65sVXcU3dCZ3m5t5Os6x0oVCUiSucipKoiJGdVRgxl5fDbSs1fjr8j6sGY/g1
         fqvh96MeQwN/sZ+egVYGPo2+Uz7W7aCB7SWTZbNSKi37MHGV7oCLH8Z6TnfeSXOxn0ly
         JkPfvragFqyRy459G+W4/sX/xCrTCod5Wh+g7wOu2pso/U5CeySzCGFST/E/uEJ735jp
         RJ3toPIfgj4GOw/ZtNTpWShgsETawB2Y8mmgehT114qVyS/eNIzT7ghP8aidsZxVkflS
         XpXTXqkXXMBmbW0aH6F6Q3k9F9KSEH1DJ+NE/l2+xcsx4NZqAbiacO0HF0Q5FO1f7T/C
         IC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IeMqwdQ4R4qb72l2CyUr/K1XQPmObo/435VbGVCnIr8=;
        fh=d7DJTqOQJvmGk+y0rdvNSzv4wsVFXWKwB+5nFH27QWA=;
        b=gpGw0U57gY56VSWb/MfLeNLtrwHxhrkZaQ6i3yseCw5FEc5cZ0cwG6juf872icY+Y+
         0wX9IEZjuZBQUlC0+oXpnHwSFiejzoBUEGL9NOIfsbLeyNcRcRHspnz+CPj+plovaVR5
         xZzeWoQHfiVftW+5QPGV2+H4SsxmCSDPfuHhAoE6dsBo9mKQ5jiWxjY9+0kk3GrtWOjQ
         TzQC2sqghqWvn7uPcX969q+NbK/wlJv4WZ3tKQ+AJFafkGv7bsMdyVFc2iAPIJjXv8tb
         0CwY9maR8nxovOGRDeeypCvGvVMMYYpwGCm3UV30QgKrKk48E9pV5P4GjpBB9fAci9lq
         jXYA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791554662; x=1792159462; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IeMqwdQ4R4qb72l2CyUr/K1XQPmObo/435VbGVCnIr8=;
        b=VlxLAYwbJ/ww0WubNLERgfLtOCcys8Q18iJjLU+GzzKbxHBvWen30A11sYOW9dn92B
         DcB/l0et+vy+kof/wKkzT5lubH+EUwcCKN1OCMECqn5jtD1ybEuJAvO3iety2HJmHfZF
         zFY5I1e8Q3sGxZRt5TNHJPJ59AiK4I3Vx8AUlq1ExTAUJ7yE3TM+q1v6lMPp9wnljnRm
         +MepdrEmdaInJ727f23nnUD7QoUmZzQggMYrSrzpkGEzp/rNoinFf4roAxMOM18E7z8v
         5IL2eTc2Xsf7+7ilo6/ln67OcrXpA+K5ta6MVtuSLnGpil+P1a0sO3t8YMVHCd5urC2M
         mKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554662; x=1792159462;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IeMqwdQ4R4qb72l2CyUr/K1XQPmObo/435VbGVCnIr8=;
        b=wMYsXfhqlQujteOexlpM05ZqvMmWY6gM5TkaBaj1QpYKVFoMReam/84EhKrQyfhIOG
         uHLuPcK1z78O4AkODAoFg0IJ4rT+EeeadjHVubPGxBj/CbDodea2PiJ70rtI0o+R7z5p
         qmSdk1fA+kTxtbCCZce1lYJ0sBwdfe8xpav3Qhv5zFVZBfiHZAsVSdB7FlEvBMNsaJok
         YidOhQolC/EU1MlN4dzPVKssvGsdMS7MkazAAI/BkM7PHUS9YiMJ761fcIGUsm+XXMYj
         GaQhE4JN/KGDnmxzlh32W3XbH7r29JWbUpZOL9a/+8Vy7sXGdpA15t+PoLigA3vV5qG6
         WwlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHP2Awf7eVKgDlkkr2x/18uELIJK3dY0w2yiNBPvudmP5wbjhcXAiXbr4H3HNdygjgHWmvlLxbnpU=@lists.linux.dev
X-Gm-Message-State: AFq9FYKartKFCAoX5g0D8I+vte++kmMVp/H6+ltwnBjB7x/Mz9gOSpfF
	CrQxLMGWGwIxYf8Dregx1yPHlyyMLkGxRdLeSYMIWMsoNai4JEfWND6YOjy0u0uKTjixdeWlrNt
	nR+GaOCpexdHBDweai62upC6gWwU4/jdMvIXwfnZjSw==
X-Gm-Gg: AYBFou0ayWja2SHmXtb3cTGoiMc/lTZ4BWgRNvQyAqx5kYmJEW9vukn09O/vJvF6cKp
	5rTdCQPf07/+lY+pINR/UDjCz3jia/Fg9iWseeyb9nkALC7s43xaJMjZN4DOdQwje2NNBSU+uca
	vk8396xeueGwPB8NM3WiQAOYvNGf9WsMyTQV32VFX20bcrGhLjNKCDh8W14gdJi+XNi9mpL9Ua8
	t7hD2LTUqRxiHyDynK8zNF1v0ZLDSQS9cJ3Sw+WQlC3LxWlZuRKWUcPJyb5chSqHIdWgH99CuRE
	J0KWFwPMsNMuFiqs5xjxrkwEQd8arLG87WbxRpnhKalbobGEVD8dN/TRfsqIVPWt0Bwz0gEQfGF
	jylrfQACuh+A=
X-Received: by 2002:a17:906:d555:b0:c25:5159:6a25 with SMTP id
 a640c23a62f3a-c31a7006d53mr258933566b.6.1791554661604; Fri, 09 Oct 2026
 07:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002154415.2270586-11-vincent.guittot@linaro.org> <20261009055318.29609-1-kayracizmeci@gmail.com>
In-Reply-To: <20261009055318.29609-1-kayracizmeci@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 16:04:10 +0200
X-Gm-Features: AclHuK_rHLMmKPRTiOq8naJcPCrEjVVB0YgPUjC0ODNFXpu1g2ATxHoAse5_WlY
Message-ID: <CAKfTPtBvGYp2S4P-k_SsFAXMVSSQ6j4F4LO44uUoDo5ZaUe1Bg@mail.gmail.com>
Subject: Re: [PATCH 10/18 v2] sched/fair: Add force push task mechanism for fair
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: arighi@nvidia.com, bsegall@google.com, changwoo@igalia.com, 
	christian.loehle@arm.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, pierre.gondois@arm.com, 
	qyousef@layalina.io, rafael@kernel.org, rostedt@goodmis.org, 
	sched-ext@lists.linux.dev, sshegde@linux.ibm.com, tj@kernel.org, 
	void@manifault.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Oct 2026 at 07:53, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> >       task_tick_cache(rq, curr);
> >
> > -     update_misfit_status(curr, rq);
> > -     check_update_overutilized_status(task_rq(curr));
> > +     if (!tick_pushable_task(curr, rq, rf)) {
> > +             update_misfit_status(curr, rq);
> > +             check_update_overutilized_status(task_rq(curr));
> > +     }
> >
> >       task_tick_core(rq, curr);
> >  }
>
> Hm.
>
> I think this mechanism added on here does not works.

Ah yes, while factorizing the code, I removed this main diff between
tick and put events

>
> Before fair_check_pushable_task() is called, we check
> if nr_running is bigger than 1. If it is we return false.
> So when we enter fair_check_pushable_task(), nr_running is
> equal or smaller than 1. We first run __check_pushable_fair_task()
> but it doesn't really matters, since it's output
> can only return false. Next block is skipped to since
> next == NULL. When we're at the check_pushable_short_task(),
> the h_nr_runnable check is always true on this path,
> so we return false.
>
> It this intentional? Or am I missing something?
>
> Thanks,
> Kayra
>
