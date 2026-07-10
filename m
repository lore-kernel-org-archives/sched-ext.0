Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E63B9933
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719249; cv=pass; b=s1YoYpCeZsHWwiZuZHZhblFSXSbpMx83dizEDonrT8e1//16lgn9KdMVLy+ZPO4VqBGg8JUQaaPB3I5WnN+4eHz4Q/AQ61NjQl2+DbJ7l5HeQj5OaYu0IRSbw/ytihpdP/G/S9rjJbYRQKptNpitrr09fPKc7PtxPO7OH3CsXpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719249; c=relaxed/simple;
	bh=+MKfz1HsD1EkJKo5cpGqW2DSegqHNYOkmGumN0TFLR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jz4T0VHXEj8rq/M1IvTa3qjltRQ1oh3KVEPff5dvvleI+x8MS9ylSwcAiCHGuXjGmW94jFpJKswqJmDLVeaMtEDqgyH4gPtJn1fAFoQXwcy7nMaxMF97/GM1w52uxLfZLTTGLrMZFfwRpANl8FrbsM0Msm+/zvzcHWg4X66INA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vcro5Wtq; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vcro5Wtq"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c7c61b5292so23881205ad.0
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 14:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783719247; cv=none;
        d=google.com; s=arc-20260327;
        b=hWwKVjJe6+niJbx4K3Saeq6b8cMytEf3QVbzUHCQ0lyfYKWAVpbA/jPy2vS46M54U7
         mVGA8GZ2stJ85w3VcL/Q3Nl4duyqTY+dzvZ90hf2/TUoO20ziINsHgHMLWM6LD+4yUEN
         lLvcYdzJd8CmopLgEeuoYFsvXIAxM/Fzl4vN4cSUWJvJOBQcb3lNC/AR+teYsx0RqN2/
         I0RdHI3rJ5QJvsckUX429PDMXeJGbB3iSoAK9M2wOWnPSRrXEMXOuhfiWn/YUGbLV/SX
         L09EEL4PJgfNFN6IIwQ7WZsa6RdLLuqpe5HD69vXUTn6/GQPfdXXXx8rUT1MN0JM51i+
         OuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+MKfz1HsD1EkJKo5cpGqW2DSegqHNYOkmGumN0TFLR4=;
        fh=iNNhlIj6CxBfnZQUSupRL0r7UuHzKtzw4VATN6b7wBI=;
        b=tDU7lRMeyoNT2TZriaKx23g1B3e/bAqhUI/tLKn1Hx6xqFVJdt9ekcnD2ICDXPbqac
         z6JimNxP4CQ4g2ytAoTdxifH7gaf4AEeeYA5sfXLvONVnyeytWnaJzh8V4C3aPDMx0Br
         mmG3slKHi8qOufsLbKjcwNNUuF9tsZe4ZOcaRXIIUR0RPx+OTT6EXoURuP7Zkrp5a1lV
         WqYYlZiKUbwww6wf69O/C3tz3KBfwRmkyn2FfLC3LBZo8WlQgdLTxXWLiYC5LvZQcdJk
         tzdQZAWO8ysK5fax8sjBilx0x5ORGZ8ijpDoxEssvxu5kj/+9zJoAIlVgOrCVDu4Y244
         jmuA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783719247; x=1784324047; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+MKfz1HsD1EkJKo5cpGqW2DSegqHNYOkmGumN0TFLR4=;
        b=Vcro5WtqUuv+FJDGHO4o7GZDpc81BqzLLSUs64ionZxo6mCkHA4Hfn9UajL3QjRUo/
         ize+Dky3LRKSVwBsrpTQB3XcOVulzIhRDIn8BpeC8KJptAQGJFUJfIsKOw6CJzZksrrK
         tnLnMh5UNbTLvDQLCUjo7KE6n0N08mpmQPApRlfs4YEwFKTenCvK+RB82miMFEkPRTMI
         18kjs07rXO0JQgpTfYRfa8g6bzF5FOcrMJP7DCAxBaTj6Wldo5VD4dL0P68rV08Bq4fO
         ImEWUra9Ltf3iDF+KHbYcyncVoIFRqZVsILNbKjIInzayB7lQrWyEV8l6QujvdDoXN0g
         zd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783719247; x=1784324047;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+MKfz1HsD1EkJKo5cpGqW2DSegqHNYOkmGumN0TFLR4=;
        b=PyiQtQQPvCeMxDxxfEquOyXOM5oBLN8Mi14NN8x8gEa2zqYhH55NV7sgeUoc5dJeQr
         Rbx7Tfc2LQw7baXSB8631wNIXfRZ7tSuAqyV6LCEjKb22RAMnKip2n3sK9b5faq2sRdf
         sGV1I52P/Sjf1itg8bTW3h77WqxRmerVOPotiSOFT0cLr7MFn801Sz1Qg12PNKtfpQgD
         lCC57bMFm4V7CsRduNFCac5uO7hM2MfZlCml5uwqMwqwXDakTGPIsz4BXKHlKJqC8Hkp
         FNkdvz6LjuHiYQrJWJaa61Nkq+flaULHcQWupwRkpaSFiGG3ZIjAJKRndyohldbAd+gP
         TelA==
X-Forwarded-Encrypted: i=1; AHgh+Rrd9HO0XOtTXD7rmWnmrxnVtXpEdwfA2uwtehziyhNw4cc2Qs37a1C1IwRpyL6JVm86o9mCxz+d89U=@lists.linux.dev
X-Gm-Message-State: AOJu0YxVYC0bJUoTzlvNdvUxGTSMtuhYj6MKpSAeT9mioWDC97zDvzFl
	2+X1aZm3jZ0MQkg/+duEAZm7e9fHCxl0vyKGR7YfsmgaGxgp5dsMkZpCalP5CfIZlPQxxggXzHy
	MMxcmgakZuzRH28zKThtg+RueXtRdaYyp3/O9/2Q=
X-Gm-Gg: AfdE7cmSaQpeFMslUiy19nJJFSjHOkB+V0gjHQYmBSwSnrylK2WafwUqzTpiTxtiWjl
	lI3nYMbt+O7estWL+5RXrKRVrBuV50Lt4Mgfsp/RGl9GDu6z2I5Q1Jmi4Z9rtA/A5jKKvVkpL/L
	xl7eS4/meJctEho4ZOLnrQDLxVszIR5Vb8L85jONyFYbKMm7oX3uUrlfmSHDAwZ1TZdlq7AG9FB
	zyBHeXxCnme/C6BzAoqVN2wt64tEmDAY6ana0H8Khyi+cVTQ0J29OUVsC5gXWsiJuuonuxtKC+/
	e0v4UMxNQeFu5QSneS8s8w48r+R5zu/UuGrZ664u2LPoUPcVc1IqXZaH5FnlNCRCKi0BtgDc2ro
	m1EPlD9VQBGuvGIKYEcwWDNmcRKktbAEkpz8=
X-Received: by 2002:a05:6a21:608a:b0:3c0:9c1b:d0b6 with SMTP id
 adf61e73a8af0-3c110a118f3mr774194637.65.1783719247174; Fri, 10 Jul 2026
 14:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260710083913.30573-1-arighi@nvidia.com> <20260710083913.30573-3-arighi@nvidia.com>
In-Reply-To: <20260710083913.30573-3-arighi@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 10 Jul 2026 14:33:55 -0700
X-Gm-Features: AVVi8Cefsh5PWfiSNV1JHxT1lujF5B41ky7iHob0GS_yUugo412UnsxOUlvlBLQ
Message-ID: <CANDhNCo3H=KjOiQqzpjqV+px6HS-8qJWTS9XWF2PN+NJPRcUDw@mail.gmail.com>
Subject: Re: [PATCH 02/10] sched_ext: Fix ops.running/stopping() pairing for
 proxy-exec donors
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, 
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>, 
	Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 1:39=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
>
> With proxy-exec, pick_next_task() can return a task with blocked_on set
> (a proxy donor). put_prev_set_next_task() then calls set_next_task_scx()
> on this "ghost" task even though the task only provides scheduling
> context and never actually runs.
>
> Calling ops.running() for such a donor produces a spurious running
> event. Simply suppressing ops.running() is not sufficient because the
> following put_prev_task_scx() would still invoke ops.stopping(),
> resulting in an unpaired stopping event.
>
> Introduce SCX_TASK_IS_RUNNING to track whether a task entered a real
> running transition. Set and clear the flag independently of
> ops.running() and ops.stopping(), as the callbacks are independently
> optional. Invoke ops.running() only for non-blocked tasks and invoke
> ops.stopping() only after a real running transition. This keeps the
> callbacks paired for proxy donors while preserving stopping
> notifications for schedulers which only implement ops.stopping().

It took me a while to understand this.

It seems you're wanting to distinguish normal task selection and
execution (without proxy) from just task selection for proxy-donation
(where it doesn't run).

I think what makes it confusing is that TASK_IS_RUNNING is not set for
the case when the task is running (rq->curr) as a lock-owning proxy
for a waiting donor.

Would it maybe make it easier to follow if the flag was
TASK_BLOCKED_DONOR? And the logic was flipped a bit?

That might more clearly cover the case you intend here without extra
edge cases that you'll have to explain (well, you're running but
you're not the donor and running... ).

thanks
-john
