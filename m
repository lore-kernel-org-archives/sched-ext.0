Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8E28505E
	for <sched-ext@lists.linux.dev>; Fri, 21 Aug 2026 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278946; cv=none; b=CUz4aFlPLsrbM6L4fvUxItgs0HZWAiSIUnpkTWS9D8xjJopnVyzBg7yI3jOIh8Via7HtJlFiONhvESrDt8+wRsBJdyFLMZX2/Ila1YrlAyn8Zp0mgvvnJZEWqtWrdebRWcgjPgl6MlDM3Imkr43ajiomtGSplJ7EBwTLu4aWwAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278946; c=relaxed/simple;
	bh=JM3latHExr5by0YDKB5HsjbdU5Ho+MSDIoZGLV10Bsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2FQZf9Cx8eCMQlVA7gV9J8oycduPsDof/T57Y3R5xgIV6pIFuXTvdzvjxhoDAQfqr3HvZLo4lW36fCq7s5j7SBIwuidskBoxRxXBVlBhQS+wntlQrz99TCVz7R8lcjtnXzcWwEn55saszLI9funVu10d8SngppUO4XNNgZCg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R91zhnDF; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R91zhnDF"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so474398b3a.3
        for <sched-ext@lists.linux.dev>; Thu, 20 Aug 2026 19:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787278944; x=1787883744; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CKHMOyyc1r9sbbC5IQBHrnYjXQZOi4RZxtdcgs2I5eU=;
        b=R91zhnDFRSv2XsR6ukOnqvBzfSWR9HFve+smfVGo0pJupQOmX0XZn15H48E41lUQNC
         RXivFRnDeQ1o0JluX97FdoJ35kjJfGVbFSAbbp5uQI29+AIUCEBbbm5kMe45g9KxtosK
         44v4wUhJuMr7xoUVguBmJ8v8hKM8HjB6Ese1/V6Y/eHGl6L0KzC4HctI+kEuDxFiIcLt
         xKyHxCl5ceVyEduojZxxSpsbXmjlUNWDS8YwE9EnPYnWuWjKgo6pFWbF5iSkbdjPJLds
         kNohI5qQsmiwSarDxOm788GD+l2OJsCryysxsJ0a8MXBOptLmcdV3DwkzSm6lW8Y6FuS
         Lz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787278944; x=1787883744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CKHMOyyc1r9sbbC5IQBHrnYjXQZOi4RZxtdcgs2I5eU=;
        b=as0D2eoJjskyod5Sg4pBCXVUdsc8b4x1AzpgZE82hzDHnB/SIppLo1vzt36Y/jf7uF
         /2aDfNC1meAEg6Qwxf2xF/i/gNej1BE5T9L6TNCkLNLfvZgjtLBiM+rOZAtbGxuIZ0au
         WpVu+UT5FlAxN5/x2kP5CyFjwJ1N38MtAIMH2g06Wv6KFMSo19dt3ZpRJPEprX5JUTF2
         G5xJM0QAVpWHqd4FpUIru+gK3fFIFay4dXp8m8mDIbJTjz2/lxZpE8r/MYrWPx/7Tf4x
         CDmv/i9gR5y2L7yI6qnl4wQF5npYBue9Bk8ccPPY3h+pJLf3o9YWkMH0xWuuWsMM/sTU
         iZOw==
X-Gm-Message-State: AOJu0YyLbcn8/0EVbEBIaAA8LOu7nLIkqwGad0M5ShgDxsHf5ecH0dab
	/7Q8cY+RMReOoKDnm8TVjgEQ0a4GwYzwoqgHwr+Xbg6nQXHDVdFCKFmz
X-Gm-Gg: AR+sD11SYJ/WBrna/1ffBTG9am+camSIraXtRq+Ok7HnrUkFH7y4kq93CYQRCNnRukG
	akriBIFBhXVtIIbfgTw2VJy0aPPgPp/OjUw1igs/EwSPA154OJOtKuqn2BSRfSJKfll9zIAKeAR
	O8eCtY0iPMru5zI4wX1S2mU5vtgN2gKgmb8quNuppSeJ2yNvefnL6eppGLlUHgTPo2Nk5TAFtfE
	Z2EJMRiBBsTQX1h8a/GlK7Oym0GJfCJXFaTOCuM8eEm2/U5546aVT5r/kOzJ7gcVIJlTq/qZvfO
	lUFWsTrD9mOCSWWa8muT03nm3sONNstfyDdeg9yZ8rrhZzitHqS3t7GO44kLNvpxclfH0K+7Nu4
	hu6/+IkniITb6syTDZguXRBVCxJyFWo+d5++DkSuQ6zf3Qkc15dY1D8OOGd0IjWgijlvQX1TwUd
	rugifVfGkBt2K0AcH5fff46ZFh8CbepIpZ/a6izi4X03fNVLvuYGO496qDMnRyLwftnw/+cEG1T
	S/1jY91HGw=
X-Received: by 2002:a05:6a20:d529:b0:3bf:b182:94e with SMTP id adf61e73a8af0-3cd2fe47253mr6121972637.5.1787278944289;
        Thu, 20 Aug 2026 19:22:24 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15543ec0fsm2319010a12.9.2026.08.20.19.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 19:22:23 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: yaoyiqi3@huawei.com
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	zhanxusheng@xiaomi.com
Subject: Re: [scx_nest] bpf_timer_cancel() unusable from select_cpu()
Date: Fri, 21 Aug 2026 10:22:18 +0800
Message-ID: <20260821022218.1941947-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6aecefa9aee94aa3a029b66f91692e7c@huawei.com>
References: <6aecefa9aee94aa3a029b66f91692e7c@huawei.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 21 Aug 2026 01:39:23 +0000, yaoyiqi (A) wrote:
> Testing showed that on this kernel bpf_timer_cancel_async(&timer) also
> returns an error from the same context, so this appears to be a broader
> restriction than the sync/async split: cancelling a CPU-pinned timer is
> not usable from a sched_ext hot-path callback at all.

Which value did it return? From .select_cpu() the expected one is
-ECANCELED, and that is not a refusal: kernel/bpf/helpers.c:4737 lists it
as "-ECANCELED when the timer will be cancelled asynchronously". The path
is helpers.c:4762-4770, where bpf_timer_cancel_async() hands the work to
bpf_async_schedule_op(cb, BPF_ASYNC_CANCEL, 0, 0) and reports the
deferral rather than declining it. A plain "< 0" test reads that as a
failure. The other two possibilities there are -ENOMEM from
kmalloc_nolock() and -ENOENT from a racing deletion, both real errors.

If it was -ECANCELED then the sync/async split is the whole story, and
the gate is neither sleepability nor sched_ext:

  static bool defer_timer_wq_op(void)
  {
	return in_hardirq() || irqs_disabled();
  }

helpers.c:1515. .select_cpu() qualifies through irqs_disabled():
try_to_wake_up() holds p->pi_lock across the wakeup via
scoped_guard(raw_spinlock_irqsave) at kernel/sched/core.c:4302 and calls
select_task_rq() inside it at 4403, which dispatches through
sched_class->select_task_rq (core.c:3629) into select_task_rq_scx() and
SCX_CALL_OP_TASK_RET(sch, select_cpu, ...) at kernel/sched/ext/ext.c:3530
and 3558. So a sched_ext callback that runs with IRQs enabled is
unaffected, and this is not specific to CPU-pinned timers.

That also answers whether it is intentional: bpf_timer_cancel() refuses
at helpers.c:1571 because it would otherwise reach hrtimer_cancel() at
1615 and wait there for a running callback, while the async variant was
given a deferral path for exactly this context.

One difference if you switch to it: the async variant leaves the callback
installed. bpf_async_update_prog_callback(&t->cb, NULL, NULL) appears
only in the sync path (helpers.c:1611) and in cancel_and_free (1694), so
the bpf_timer_set_callback() re-arm your original code needed after
bpf_timer_cancel() is not needed after bpf_timer_cancel_async().

Your flag-based workaround is what the Rust schedulers do and avoids the
question entirely, so none of this asks you to change it back.

On documentation, the async return codes are all listed at
helpers.c:4731-4740. The gap is on the sync side, where
include/uapi/linux/bpf.h:5456-5461 gives 0, 1, -EINVAL and -EDEADLK for
bpf_timer_cancel() and not the -EOPNOTSUPP you hit.

Thanks,
Zhan Xusheng
