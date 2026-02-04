Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C013E8C49
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201237; cv=none; b=CmTaloxAZ3DJ3p0T89Wd8hcA5tfSQIMky4rSrhajiKYtr0fYDzD6Wm8R4FnezIvMGBlhrBgYHUMrt2Shnv0faG3UzmyAFZoT4Elj1CYFX1PnMR6sjCKX0XYz1B4G3ZIsP3uq+V8gXy68JvJs0tzjzZ0QvtXbR2PSJgWBm/dWOJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201237; c=relaxed/simple;
	bh=lYIhogZNmW/tEFe2sESCytnyVuzRtPXNqNpsN3bSX0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T1Ohc9c1ILoX/oPXRfeWnpaWgHAZXTFUOZsWNXOPzoT4hmg/j42yYUViGdyEZUUpqEOrZPMQJDVR6I3I6ucXCVW1Q+dcnHVZIqjcSQdgrwSrnfx7i2Wchr43Q9Sj0D5I4+nuNUz3kT3vWh/EhdAaLQk4JpzqSo4Wi2PSizccOk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yAR3KS58; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yAR3KS58"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48069a43217so76711435e9.1
        for <sched-ext@lists.linux.dev>; Wed, 04 Feb 2026 02:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770201235; x=1770806035; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VWQJDn+m3kIbt58PZ0I1Zknh/dvrXG4rZcRtcTS57x0=;
        b=yAR3KS58jxs1zh9LsRjfAW+ikcKI7RkUUU2vZMQbi9F2xZ+6kgyO4C3iBN5TqJBqWd
         dHOC2MRL2lpkh2d+SjuqsyUFsPp02nCUDcvJe9H6+qfnoGuFvM905brDGeE+LLc0tphf
         I0p3CUbZ2YVxF63l9GW7gJalNplpXXCdoTPik1mGZsgMcu/6rkdEbB0OBscGRTomnORB
         zko4fv9rO+A1jQDRxdoowENJTzL0AjYd+TLEW5+op3NsjxKeuxW21PQ6HHgD+3Wq8Qol
         1XVHh2rN49a8KrwqGE+Sw+YSmcAf1WLi1Yz55iQMLVON/SfU8ZSDk4TlKMEFnKv94Row
         8jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770201235; x=1770806035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWQJDn+m3kIbt58PZ0I1Zknh/dvrXG4rZcRtcTS57x0=;
        b=LSgdw6s2SLI8yjH645qqUGMKe0PnNie2UqVT0aKu3EDbqSmvafTPVT8uoQT2Q4Oxk9
         EBJlJO089QjZgZC9XtjKpomM7ZmGwZwzys909KiLLJsPIs1Qf1VwuAtOM3mZnaSa1wi3
         2yJs8Vv1lSQYGccUQge/zWh+cRJVXfYKuzABeaxtnkLV92UAX/g4ux/qaxJt4btKryoJ
         WE9imTva48W5DJsiZZYODrKof9TvmxJp9kOV+LrUzKEJX+Z10kX4yzh+XEmdntNjU5qo
         f7KR6KqjsRQt/FiuBDzqNXV9xkY+kkjC/cOYxJ4+/J5UeWhv3wk+x4kO4OZKZR6EfxYL
         9iJw==
X-Forwarded-Encrypted: i=1; AJvYcCUHzwk4v69fHGkynyCdsC8twTh3HZl5ef668+zZXGkFrl3qVXTvWaNXL/PCtjAc1Jpom5/whCtHpR4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5h4jUOFbI9BF4wNaRoLrw+jqAKu2S61isvDcUws21hOVIRlKq
	hJROd4mw9MPxSviWFr0opPiL8srOKECFpAFqVxHBP6OvVF9uYgYZgu3wfXvVf0IhQryaGD2JhHj
	9Pn2CqpTFAxFKDw==
X-Received: from wmk23.prod.google.com ([2002:a05:600c:297:b0:480:3842:3532])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b70:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-4830e9313bamr31576025e9.14.1770201235530;
 Wed, 04 Feb 2026 02:33:55 -0800 (PST)
Date: Wed, 04 Feb 2026 10:33:54 +0000
In-Reply-To: <aYMbZcRNR5AUNiUt@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260201091318.178710-1-arighi@nvidia.com> <20260201091318.178710-2-arighi@nvidia.com>
 <DG4GH47JCNH5.36CX78QFOYVS6@google.com> <aYMbZcRNR5AUNiUt@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DG63YSLEHD26.3C1YRKNOTU9LA@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Christian Loehle <christian.loehle@arm.com>, Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed Feb 4, 2026 at 10:11 AM UTC, Andrea Righi wrote:
> On Mon, Feb 02, 2026 at 11:56:43AM +0000, Kuba Piecuch wrote:
>> Hi Andrea,
>> 
>> Looks good overall, but we need to settle on the global DSQ semantics, plus
>> some edge cases that need clearing up.
>
> On this one I think we settled on the assumption that SCX_DSQ_GLOBAL can be
> considered a "terminal DSQ", so we won't trigger ops.dequeue().

Correct, I made this comment before we settled it.

Thanks,
Kuba

