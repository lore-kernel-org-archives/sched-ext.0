Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D15A3EDAC1;
	Mon, 24 Aug 2026 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561713; cv=none; b=A4ppXm56Z0NvrBC/A1CL2fLlecERfD8CjTs8qmE98sUc45JLIdbD7pykMnbbX8Z0ZiMZVXhNUw4/UNPAvu3KJ/Jzdt7m0VNJX/P7Wpt9IL+cpSWFrYoxEqc/Ab+bgx38NGWInnT9S4Mmcfcgu9XEJtguUPu2Dbcw7q/rU/6ccvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561713; c=relaxed/simple;
	bh=TWscpbQrqiMVpEVa/8yf4QOnQXdcROhMKZ5oszI6ifM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHlKsQn2an5RzoEz7xDbjOJJt5dIQ/KkRjrn9tIcIuPvi9i0kegn5XlHXzp5NW/j4MczFhPErsECtmJElz4FMvute7hWe8PhcbhXE7Z01lw+oOdunVFthHylY/EOIGcwecFjloUVFhobFKTSUdWl5342OpuVTxjTed5AthlODxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KZeoyMyp; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KZeoyMyp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=KDhhF+ZgusE+W07MAQ4n6+P9/+tUkRMM7nYBl2A8g1s=; b=KZeoyMyphFaLrEQr9dR1AiUEqg
	fC2qIpyKyIZ+hZPuYWsUJe1HGL2CWsRwsmgaNyjcrU2VjQW96ldjO0sB+TO7tiDlYzenzzwaOOPdk
	qWaIcto3hTGK8lqhahmvY2KO4oA35piWtkjRX3VEKWUYcHim3gJ93Jwe5NkEAFedB3LFypJHBnlfI
	ZbaiN9fCEjTzgf/r+Kwj6XFJKou1Wx+9Mse8qta0vwWYOQ7gwN2/T6tsSAeW72JxH1Uik3apoOpAy
	z7elappPm038uXhm/OQcn0fqbu0Y8ic2kD3jq6t8d7+cQtvn21fEd39a8pCFDCz1faFJlN+MrSo6E
	8C7i8vvA==;
Received: from [58.29.145.179] (helo=[192.168.8.203])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wyQSB-008QCJ-5a; Mon, 24 Aug 2026 10:54:51 +0200
Message-ID: <b5c99964-cc98-4ec7-87c5-cc70142395b9@igalia.com>
Date: Mon, 24 Aug 2026 17:54:42 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched_ext: Sync common and compat headers from the
 scx repo
To: Tejun Heo <tj@kernel.org>
Cc: sashiko-bot@kernel.org, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Gavin Guo <gavinguo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260818205711.3175265-1-tj@kernel.org>
 <20260818205711.3175265-3-tj@kernel.org>
 <20260818210732.AB27B1F000E9@smtp.kernel.org>
 <e2f7a97a70966c6d132a494500b55811@kernel.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <e2f7a97a70966c6d132a494500b55811@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 8/19/26 6:33 AM, Tejun Heo wrote:
>>> +/*
>>> + * True if the non-sleepable BPF trampoline prolog (__bpf_prog_enter) calls
>>> + * migrate_disable() for the current task. Recorded once by
>>> + * scx_lib_init_probe, an fentry program on bpf_scx_reg() that fires during
>>> + * the natural scheduler-attach call chain (auto-attached by scx_ops_attach!).
>>> + *
>>> + * Defaults to true (conservative). Over-reporting in is_migration_disabled()
>>> + * causes local-only dispatch, which is safe. Under-reporting can crash the
>>> + * scheduler, so we err high if the probe somehow fails to run.
>>> + */
>>> +bool __scx_prolog_disables_migration __weak = true;
>> [Severity: High]
>> Does this default value actually under-report if the probe fails to run?
>>
>> The documentation indicates that the fallback should err high (over-report)
>> to avoid crashing the scheduler. However, looking at the slow path in
>> is_migration_disabled() below, when __scx_prolog_disables_migration is true,
>> the macro evaluates bpf_get_current_task_btf() != p. This causes it to
>> return false for the current task, which means it incorrectly assumes
>> migration is not disabled (under-reporting).
>>
>> Should the default value of __scx_prolog_disables_migration be false
>> instead, so that it falls back to returning true?
> The comment and the default do disagree. true matches the stock pre-v6.18
> prolog behavior, so a failed probe still yields correct results on stock
> kernels. However, if the probe fails on a kernel that cherry-picked
> 8e4f0b1ebcf2 ("bpf: use rcu_read_lock_dont_migrate() for trampoline.c"),
> is_migration_disabled(current) under-reports, which is the direction the
> comment claims to avoid. Erring high would be defaulting to false.
> 
> Changwoo, this code is synced from the scx repo. Can you update the scx
> side, either flipping the default or fixing the comment? I'll re-sync
> afterwards.

I submitted a PR to fix this: https://github.com/sched-ext/scx/pull/3766

Regards,
Changwoo Min

