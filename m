Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0153DA7CE
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203785; cv=none; b=GQBw0tou/bNGWwzge3dGZKRBvnLW/vXTr7qZmBrkB8/Yt+spcKqKs8XfKwlrwE3CDx2jzFEqLvTNDihIPoDKUryOcRZCBlrvp6FkNXicM6Xk5LcfJhLVfXVv/cLnYe3XTPU3kFkA7SPgMV/D1/MKoklJ7Ft+TxLFFQQ+JFk949g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203785; c=relaxed/simple;
	bh=RknE2qaMvd+Ec3BSU4pR4Us57yVfETvAFmPmZxmCSUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwHmbpig0RN+Aj8gO099zmN2eAMldkXFGNxlAfBtMyPnT6VF/3HhjtYM2PVPrEsOGcVq0E9RJlaNRMs6lnVw5/1M/I3eSKNobH1ntHohV9UQrQEfMwz+WCOWvhqjho0kEqN4JApUTvzo0/TP55696ATvfHM7br9sgcAZYIsP8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIFOU8op; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIFOU8op"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45f171cb842so521148b6e.1
        for <sched-ext@lists.linux.dev>; Wed, 04 Feb 2026 03:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770203783; x=1770808583; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RknE2qaMvd+Ec3BSU4pR4Us57yVfETvAFmPmZxmCSUc=;
        b=LIFOU8oppZuz20KU/10knq0NBCqS6V1VhY/nTiOuqurnc5NZP2OrNXq9to781Cw0VQ
         a1AHrZsjAX5Ok4hC91xvFBa6qbmmn26gIhev23Fgwnz/uFlg4JG7KNu5XInjGx2toNV+
         bsb3koSaSWiugkO6bfNXrr5TYQS4NRUCuJNCERf5KyrsAO2Tq54psEpWxjAGmn5Em1Yu
         vAG0FS8Hp6uK5OwbwVLkG96koEDRtqobMCLRnl3due3Nmma6sjtiReEyBnlVEoEPAK65
         20SHX7mlRl7cGipCR/V1OQch09CLtULSZyYXHYF3XikFVpbS5XnW/SK8cA51cKbZVRfU
         I08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203783; x=1770808583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RknE2qaMvd+Ec3BSU4pR4Us57yVfETvAFmPmZxmCSUc=;
        b=mpFuut9eLshQ9OtwAChMs4v0Gcxf1iU988PxTpyJ8ncdmUiA588IuICAZmlREYjHvk
         fIEW0d6IeA5rT8iJzPGDIG+9/Zu24RQnY7ANG03HaJY9bOch17GY8JuQsFI5CFFX+a0s
         9RrOa6iq3I9E3Z0iKaoT9QmIQl44H86hm90fEZRZvL2livMTNpKpf+OubCuKQYQGXDqg
         URfbd6b8ti0QohwrOEfOBYZU3Ln6cr3eZXahP8FyZ0Y8ydrA6fwnl/dhlEeZ2CUqXid5
         DrHs0bL/9P0QTUsTiXhqNSyTd/8Xsu+LV3HEwl+7nqOkmYbHT0HOeG2ngBItITe1rbar
         FMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTCfMw+Rw/SOJK9uP4myHSM+xGE1MsOaiLuTbMVRmzgIfGV57i6LVPSLIP2GDdSfOcCmQB4DndduU=@lists.linux.dev
X-Gm-Message-State: AOJu0YwCe30Z3QHrL30XAtIrvs6r1i51TBNIJW4g9vr+/6lFxIS+il82
	AMkEwbm2gJf+3/vLSI2XzBt75SUbXoZdFFzmsV9PiEytBfUAbGnB0fflNatLvdTYIrqJ/w==
X-Gm-Gg: AZuq6aIQWmS2hgWM5CZp/cd0NPEulHu+X6aWEfmAAajViTM/wJAO/6SFaa8YORu95q6
	Dw65F7wDzJ4Nrh4dnrHFp9Cegclizz81fzcRvrOAvlZz0Em4WMqNdVp+pENO44Gbau3bgKQ7WiV
	EdTLSWcGW26jGuYH8ay+gumRjEQVltMmIPbl2E0TRkDJyg7n6TYNVTDnJ3X365UNinHaBi1FDXJ
	nahJlpy9kPBp/cQQWhb6cFWI501MILCJw1puYNLQD1x2JmaP/2YV2KNYjiyGHzPOKe80dxfScIX
	r1fFBoUdt7+QalXp2LS2vmjAVcIDuhdIVcgKg27oxGGUXlmc5FL7FSQpi/XrJGFvpmfqtnCn+wz
	2ZTC64FkrXLlebyInQmLt9hUIeKg1QwY/dy4Lx2vmKP8KxYdrN7GavzrQ3VOCKqCrg2HLs40hco
	wKirg=
X-Received: by 2002:a05:7300:1802:b0:2ab:9d23:f0b1 with SMTP id 5a478bee46e88-2b820efade0mr2048673eec.13.1770198132127;
        Wed, 04 Feb 2026 01:42:12 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e1296dsm1265103eec.4.2026.02.04.01.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:42:11 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: arighi@nvidia.com
Cc: bsegall@google.com,
	changwoo@igalia.com,
	david.dai@linux.dev,
	dietmar.eggemann@arm.com,
	emil@etsalapatis.com,
	jake@hillion.co.uk,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	newton@meta.com,
	peterz@infradead.org,
	realwujing@gmail.com,
	rostedt@goodmis.org,
	schatzberg.dan@gmail.com,
	sched-ext@lists.linux.dev,
	suzhidao@xiaomi.com,
	tj@kernel.org,
	vincent.guittot@linaro.org,
	void@manifault.com,
	vschneid@redhat.com,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH] sched/ext: Add cpumask to skip unsuitable dispatch queues
Date: Wed,  4 Feb 2026 04:41:58 -0500
Message-ID: <20260204094202.3917675-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aYGzumDW2sQ8xQSD@gpd4>
References: <aYGzumDW2sQ8xQSD@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrea, I have fixed those issues in v2:

https://lore.kernel.org/all/20260204093435.3915393-1-realwujing@gmail.com/

On Tue, Feb 03, 2026 at 09:37:14AM +0100, Andrea Righi wrote:
> Did you run some benchmarks / have some numbers?

I'm working on collecting more detailed benchmark numbers. However, theoretically,
the bitwise cpumask_or() should be much cheaper than a DSQ scan that results in
multiple cache misses during task structure dereferencing, even for small queues.

> It's true that we save the O(N) scan when the DSQ has no eligible tasks, but we're
> adding cost on every enqueue: cpumask_or() on potentially large cpumasks can be
> expensive.
> ... for small queues or mixed workloads, the cpumask overhead probably exceeds
> the savings...

To minimize the enqueue overhead, I've optimized the dispatch_enqueue() path in v2:
- Use cpumask_copy() instead of cpumask_or() when the task is the first one in the DSQ.
- Skip the cpumask_or() update if the DSQ's cpus_allowed mask is already full.

> The cpumask is only updated during enqueue and cleared when the queue empties. If a
> task's affinity changes while it's already in the queue (i.e., sched_setaffinity()),
> the cpus_allowed mask becomes stale.

Fixed in v2. I've added a hook in set_cpus_allowed_scx() to update the DSQ's
cpus_allowed mask whenever a task's affinity changes while it is enqueued in a DSQ.

> I don't see the corresponding kfree() in the cleanup path.

Fixed in v2. I've added an RCU callback (free_dsq_rcu_callback) to explicitly free
dsq->cpus_allowed before freeing the DSQ structure itself.

Also, I've restricted the cpumask allocation to user-defined DSQs only, as built-in
DSQs (local, global, bypass) don't need this optimization.

Thanks,
Qiliang
