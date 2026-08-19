Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F5390CAB;
	Wed, 19 Aug 2026 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170115; cv=none; b=IImSp4fBZZHhWVo0CGIbEhhKvzS1dwGnFC4jAHo6wEwd3y7EbKB/+K/nk/KNR5h7VIWlRN5flhUSgnv6zMVBM4xeoPv/wuv2TexvN54s8oeYZLNZrJcncQYoTd90rHOFbhBqIQ4mlRN3IqjllsDNxXfwS1gtqS/KPaMs3bcF9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170115; c=relaxed/simple;
	bh=UoD2llVl1cMPafKga/q2Sl5f1KAANyS77u+fnt4/V3M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=sYycFxAaOrULXo71aunY4iclW25UUZ0xnKImp7dlhr5CtIdgGerEiLVjAqGyfl3KIfelWHfyM2/XD4d5voTkXMB+OgL8hFwvA9+xVOOJddm5ADkob+b+d2yZC9ByOfstXTq/Zw9IUnL/Zu8hCf0WNyQCH8igoder5PAOGvF4Kyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyW5m3xN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyW5m3xN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0C71F000E9;
	Wed, 19 Aug 2026 20:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787170113;
	bh=DWefprdCjuMlbolzkZB8hlEHgmZcllsAC6tbOy7bxGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YyW5m3xNH/5e46dKNtn0XxnDZN7+2UC+kY42cPsvM2JmJVC7s0ICfOIIOZMUOrINf
	 aAUiFbLpN1oUFhewg//M7y4h1/96sGH41MnGGXB+oZps5iWpp3MYL7RZ3nxN1RgHro
	 sb3uFKr8xm+zAluEVTFnJ+NYL4OclXcAO/2BoQ4D2h/p/DfE+9pxqNQZAWF1kLD4Pz
	 SA4JRA/0bvufOO3wa7kgbXW5kuQqKFAiAkgo26BCJH9XfdT+0RL1/XOvgFgCX+MUHh
	 pVqPeONrn6WlmoCUQmDEl5h1VSHemZbhZW9wMu3xF0cvo80nG0tKhSMfPiZ6KbpCpc
	 +plsBMAdY+TZg==
Date: Wed, 19 Aug 2026 10:08:32 -1000
Message-ID: <05fa2ecdf1468ca7454244941343626f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: luoliang@kylinos.cn
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Docs/admin-guide/cgroup-v2: document BPF scheduler
 callbacks for cpu.max and cpu.idle
In-Reply-To: <20260819031244.178638-2-luoliang@kylinos.cn>
References: <20260819031244.178638-1-luoliang@kylinos.cn>
 <20260819031244.178638-2-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Wed, Aug 19, 2026 at 11:12:43AM +0800, luoliang@kylinos.cn wrote:
> -	This file affects only processes under the fair-class scheduler.
> +	This file affects only processes under the fair-class scheduler and a BPF
> +	scheduler with the ``cgroup_set_bandwidth`` callback depending on what
> +	the callback actually does.

The "CPU Interface Files" preamble defines the categories that the
interface file entries refer back to and it only knows about
cgroup_set_weight:

  * Processes under the fair-class scheduler
  * Processes under a BPF scheduler with the ``cgroup_set_weight`` callback
  * Everything else: ``SCHED_{FIFO,RR,DEADLINE}`` and processes under a BPF
    scheduler without the ``cgroup_set_weight`` callback

With cpu.max, cpu.max.burst and cpu.idle now referring to
cgroup_set_bandwidth and cgroup_set_idle, the preamble no longer covers
the entries that follow it. Can you please update the preamble to match,
e.g. by making the bullets refer to the corresponding cgroup_set_*
callback, and resend?

Thanks.

--
tejun
