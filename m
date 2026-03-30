Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C83AEF3E
	for <sched-ext@lists.linux.dev>; Mon, 30 Mar 2026 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860727; cv=none; b=kf4MqBGuUCjV2mVgVV7rJ7E+d+w/DtHUhDCCawtiewdV5g2pa6h/1qoF3NylcEjIM5WTBnA05gg/uZYv7d6YvUsm2Y3XAz7CiXmtXcDu41s12s4AZPQYmUldHbFN38iLEcPkoB5Nz87gHoOde0PQCMm/mrdOXcvZwYFfdw64YNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860727; c=relaxed/simple;
	bh=98sdyolT1OKoCwLjOAj9S+sRAFcMt9W5WTQ7JMzmuBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJyw2f4vUPwd5edHjC/4/HixGla5hNtvvXRt3NZg+7NtS+qf7QncKt/8BYQ6jxUfCCJMhfUURZpXT0wbZUNaKvumqoytQYKJWoh43Sdc3ldCV6BZrMGkcbYOzyj4uWSjEGiTAVxv1xx9YXttkcyDFIZ0LQrzr7y+5ZLVYzJoTe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=si3/nsyV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="si3/nsyV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9A4A1C00;
	Mon, 30 Mar 2026 01:51:58 -0700 (PDT)
Received: from [10.1.32.28] (e127648.arm.com [10.1.32.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF6483F915;
	Mon, 30 Mar 2026 01:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774860724; bh=98sdyolT1OKoCwLjOAj9S+sRAFcMt9W5WTQ7JMzmuBc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=si3/nsyVAJH4N/sQ2+EL1P6BO4wM+2mWhT62htVYV9FUlxDMoiMC2yMuw616Zv5us
	 Lw5enTTAbTQvbaKQ14Kcjz9QtMYdqDXncg/IA8fCzVA8iMreQaFyrJg1yxHo3aDlTK
	 hR0aFbSl/DAoc/upgjnAGrIFkV+ZhjS6wSHLtKC4=
Message-ID: <54052c95-922f-41e1-b644-7e2cbb8c49d0@arm.com>
Date: Mon, 30 Mar 2026 09:52:02 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET sched_ext/for-7.0-fixes] sched_ext: Fix SCX_KICK_WAIT
 deadlock
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260329001856.835643-1-tj@kernel.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260329001856.835643-1-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/26 00:18, Tejun Heo wrote:
> Hello,
> 
> SCX_KICK_WAIT busy-waits in kick_cpus_irq_workfn() until the target CPU
> reschedules. Because the irq_work runs in hardirq context, the waiting
> CPU's kick_sync never advances, and if multiple CPUs form a wait cycle, all
> deadlock. This was reported by Christian while testing on arm64.
> 
> 0001 fixes the deadlock by deferring the wait to a balance callback which
> drops the rq lock and enables IRQs, allowing IPIs to be processed and
> kick_sync to keep advancing during the wait.
> 
> 0002 adds a selftest that creates a 3-CPU kick_wait cycle to reproduce the
> issue.
> 
> Based on sched_ext/for-7.0-fixes (db08b1940f4b).
> 
>  0001-sched_ext-Fix-SCX_KICK_WAIT-deadlock-by-deferring-wa.patch
>  0002-selftests-sched_ext-Add-cyclic-SCX_KICK_WAIT-stress-.patch
> 
>  kernel/sched/ext.c                                 |  95 +++++++---
>  kernel/sched/sched.h                               |   3 +
>  tools/testing/selftests/sched_ext/Makefile         |   1 +
>  .../selftests/sched_ext/cyclic_kick_wait.bpf.c     |  68 ++++++++
>  .../testing/selftests/sched_ext/cyclic_kick_wait.c | 194 +++++++++++++++++++++
>  5 files changed, 336 insertions(+), 25 deletions(-)
> 
> --
> tejun

For both:
Tested-by: Christian Loehle <christian.loehle@arm.com>

Thanks for fixing this!
