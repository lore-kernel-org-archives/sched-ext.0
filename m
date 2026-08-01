Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130F22173D
	for <sched-ext@lists.linux.dev>; Sat,  1 Aug 2026 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785580529; cv=none; b=ljZXmz8m/RqSkHWG+IzOm6oVAJtuVK48XRkIykOBfG2ggV8EGSkhY/5j4YdW4kUwyp/SleB4F2T1Y0lEZ7DfYsJOqco2MxjTn4SEsFk7ZIzoXUuLYSbHA4XSXo12zTEL1KbWh7jhbKVy3zTIbmEawPBF5hKonOGbgrcAWA49oco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785580529; c=relaxed/simple;
	bh=bwlUSI7TgtwbSZUG1kvau3EDCZuauBS7kN5yVJx+KeU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QV6fLyr85OEpzK9FwiFYhpqVbzwU1xkLbgJMlEohTv+UnFuQh0ePCYZieMLDs2eX520ppUm1caK0pflr416LIogNRvzCmTu0oCRoSwRP40gD+oAgYp+nshPQ/FUdnO5N6Rox0AxKJ5nrqsJ0gBt0l72Ip0+SjqR3gifQVVSw8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0e0enxq; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0e0enxq"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495495ad5ddso2337175e9.3
        for <sched-ext@lists.linux.dev>; Sat, 01 Aug 2026 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785580526; x=1786185326; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bwlUSI7TgtwbSZUG1kvau3EDCZuauBS7kN5yVJx+KeU=;
        b=M0e0enxq1tmUmincSKQxgAsYUXYSbVowhxdzHiWlAI8yzqAv2T1XXqPKOzOCzOiWxK
         bDB48k1DQxqOg0m/9NTadeQpydnmZHGJVkP/jVt4TWvMiQuoMGO+q5CHkJPEry4eLFpz
         kUZwrZv0OPKTnLaB8m38/rHX4yjL4srJ/RyYz4rBK+NR4TZSp+3RWbJ6c+PlNnFqpdBS
         i1Y+LDc0RtbeME1YSxy9lm03oOeVBPa5ZoA4PtpJRsHDBHhKInszshFDurdrpK4uu3yJ
         8caJzLSadJ/UnZQK0ccGtdlpZslf5kTll8zlayBcVHsF+H6djFF6mmc0YVzw2fFGfATX
         eB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785580526; x=1786185326;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bwlUSI7TgtwbSZUG1kvau3EDCZuauBS7kN5yVJx+KeU=;
        b=ZvVOHwS/8aYeiXAqhGVrqI9hFoCt3nE9egQxibWUxm0KocpnjXoRpU4U7Z/u58ONSR
         ZnMTYFX4dfD5Muv2yzOOkLbaarFA/IvNBImad450C0fiktdlu+Tu7fsV9XU3CIgMVqPo
         K3LC3JoH0ydwp2j2ai6vJ72h8s83Z2Df06LgFGQLETxFpaY7nT89nVJ6xVfIUqvSyo5j
         Y/mK4HAp8Jt98GB1668iz0nuqN5W4TomYqc5aJBkgHGbz1phayASUE8MrvU6tG3eslPV
         jCkMRILueto8+mLWadygaK8W7m9PJQ1Lk+wu6cfplhXMfkLj/5J0iyElXV5WUIJhGi+9
         iz7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq1uREiPI5XkmcG7DQcHf+9qExti6GGNY1zcOvotUaafkVH2Uj2nzV2rXmCccOFwKkfpXoP4AISj1o=@lists.linux.dev
X-Gm-Message-State: AOJu0YzYpumuiYM0bXNABHXvNDUJ0I4syRTOCh/wwi8p7StxGT+zIImm
	0QA4ydi13Q+mWA5LDGY/A4PPdZTzu45GaoAZaV2Kv/n39IxKXnB02VrcxErh6lyl88iKsWZb+iW
	BYnIHW7ALrQfprA==
X-Received: from wmoi20.prod.google.com ([2002:a05:600c:4814:b0:495:6708:efe5])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:2294:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-4980c67af97mr31980915e9.15.1785580525709;
 Sat, 01 Aug 2026 03:35:25 -0700 (PDT)
Date: Sat, 01 Aug 2026 10:35:24 +0000
In-Reply-To: <amy-pKcguBtwJQZE@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260731090334.2911948-1-arighi@nvidia.com> <20260731090334.2911948-3-arighi@nvidia.com>
 <DKCPMDMRE6FN.3EII6EE13O4SY@google.com> <amy-pKcguBtwJQZE@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DKDJGWYH2NUN.1OZFGQKJUVFHH@google.com>
Subject: Re: [PATCH 2/2] selftests/sched_ext: Make allowed_cpus idle
 validation race-free
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri Jul 31, 2026 at 3:26 PM UTC, Andrea Righi wrote:
> On Fri, Jul 31, 2026 at 11:12:09AM +0000, Kuba Piecuch wrote:
>> Could we check a stronger invariant by also checking that the bit in the idle
>> mask is set if we're running an idle task? We can get the idle cpumask through
>> scx_bpf_get_idle_cpumask() and check bits without clearing them using
>> bpf_cpumask_test_cpu().
>
> I don't think the other direction always holds: an idle CPU can be claimed by
> another BPF idle CPU selection helper, which can clear the idle bit before the
> CPU necessarily stops running the idle task. In that case, observing an idle
> task with a clear idle bit is legitimate.

Right, thanks for pointing that out.

