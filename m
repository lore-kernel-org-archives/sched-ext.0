Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1373FB041;
	Wed, 29 Apr 2026 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466853; cv=none; b=kMSAlZtpcVRtuaeMhCYq2LMqBeMc2gxUyuH18exjRa9vGo64J6q314hegN+l8gH91zgB2ia7tfI4HtRhmud6ujUXsRwCdnUYzvaiPSj+TmcmYTx1PaKfGGJf+rY5nHnmekFpYcYppiyKZUKUu3n+wBHpzOr7pWwr/TiT6QMLNYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466853; c=relaxed/simple;
	bh=OYCoyV9bPw+ESZ1VQhkFFIuXssRkmVHLfDSUvozeWys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AG16nzCVWOsR/NQAdyEpTxVpbCeXSDynrC/EQdCoqbmSsTTjMVDJfooHCEw0AaPofQ/OMii8O1MJfSGM5eNzNjG1d0XsiJydbtXzj0HG7HSCNHWkuxtR6j512s0C0vTb773BLv5Cz1PIiUukEBPsmJ2SBq6b4uVunlG8Md1xSVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rGxYFjEj; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rGxYFjEj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TkGQq/yqw0EUeTirhX4EILLNiYMPtEn3u8rm5dJTykg=; b=rGxYFjEjRY492lrjb/STtqVdhm
	Pv8jNSManPPywGl1YmBRlW4MI9bP7dSFXiII9h6sOgnhDOElw/RS2/f6ukfAGHspd6AQtaEeB24NU
	K5+7q/jPBSDJ31O3+z0Wzqqdku+SH2M3CN273MOQ8BHIsEVsmiWagU1otOjV2dC1hOpCnFXxT/7m0
	UMtTSxTmsJ7CPd7/6kYB5M91QycZMTWUU810yZxG7XbH9tCdz69mC61TX0FcslDEJOA/1RLi3gtOn
	NhP8p47mWLLUNBm68y4a1g7Sz7/qeD4aSE7fMTeSRJmxBFGhdQ+/IKId2K7n3nIbkf+nUr5zOjY/D
	UuOCMbng==;
Received: from [58.29.145.179] (helo=[192.168.8.203])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wI4K5-003w5i-NP; Wed, 29 Apr 2026 14:47:25 +0200
Message-ID: <b8bc70c1-8914-4a39-825d-e94cfb983d60@igalia.com>
Date: Wed, 29 Apr 2026 21:47:15 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] sched_ext: Add cmask, a base-windowed bitmap over
 cid space
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org, Cheng-Yang Chou <yphbchou0911@gmail.com>
References: <20260428203545.181052-1-tj@kernel.org>
 <20260428203545.181052-11-tj@kernel.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20260428203545.181052-11-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/29/26 5:35 AM, Tejun Heo wrote:

> +/*
> + * x86 BPF JIT rejects BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on arena
> + * pointers (see bpf_jit_supports_insn() in arch/x86/net/bpf_jit_comp.c). Only
> + * BPF_CMPXCHG / BPF_XCHG / BPF_ADD with FETCH are allowed. Implement
> + * test_and_{set,clear} and the atomic set/clear via a cmpxchg loop.
> + *
> + * CMASK_CAS_TRIES is far above what any non-pathological contention needs.
> + * Exhausting it means the bit update was lost, which corrupts the caller's view
> + * of the bitmap, so raise scx_bpf_error() to abort the scheduler.
> + */
> +#define CMASK_CAS_TRIES		1024
> +
> +static __always_inline void cmask_set(struct scx_cmask __arena *m, u32 cid)
> +{
> +	u64 __arena *w;
> +	u64 bit, old, new;
> +	u32 i;
> +
> +	if (!__cmask_contains(m, cid))
> +		return;
> +	w = __cmask_word(m, cid);
> +	bit = BIT_U64(cid & 63);
> +	bpf_for(i, 0, CMASK_CAS_TRIES) {
> +		old = *w;
> +		if (old & bit)
> +			return;
> +		new = old | bit;
> +		if (__sync_val_compare_and_swap(w, old, new) == old)
> +			return;
> +	}
> +	scx_bpf_error("cmask_set CAS exhausted at cid %u", cid);
> +}
> +
> +static __always_inline void cmask_clear(struct scx_cmask __arena *m, u32 cid)
> +{
> +	u64 __arena *w;
> +	u64 bit, old, new;
> +	u32 i;
> +
> +	if (!__cmask_contains(m, cid))
> +		return;
> +	w = __cmask_word(m, cid);
> +	bit = BIT_U64(cid & 63);
> +	bpf_for(i, 0, CMASK_CAS_TRIES) {
> +		old = *w;
> +		if (!(old & bit))
> +			return;
> +		new = old & ~bit;
> +		if (__sync_val_compare_and_swap(w, old, new) == old)
> +			return;
> +	}
> +	scx_bpf_error("cmask_clear CAS exhausted at cid %u", cid);
> +}
> +
> +static __always_inline bool cmask_test_and_set(struct scx_cmask __arena *m, u32 cid)
> +{
> +	u64 __arena *w;
> +	u64 bit, old, new;
> +	u32 i;
> +
> +	if (!__cmask_contains(m, cid))
> +		return false;
> +	w = __cmask_word(m, cid);
> +	bit = BIT_U64(cid & 63);
> +	bpf_for(i, 0, CMASK_CAS_TRIES) {
> +		old = *w;
> +		if (old & bit)
> +			return true;
> +		new = old | bit;
> +		if (__sync_val_compare_and_swap(w, old, new) == old)
> +			return false;
> +	}
> +	scx_bpf_error("cmask_test_and_set CAS exhausted at cid %u", cid);
> +	return false;
> +}
> +
> +static __always_inline bool cmask_test_and_clear(struct scx_cmask __arena *m, u32 cid)
> +{
> +	u64 __arena *w;
> +	u64 bit, old, new;
> +	u32 i;
> +
> +	if (!__cmask_contains(m, cid))
> +		return false;
> +	w = __cmask_word(m, cid);
> +	bit = BIT_U64(cid & 63);
> +	bpf_for(i, 0, CMASK_CAS_TRIES) {
> +		old = *w;
> +		if (!(old & bit))
> +			return false;
> +		new = old & ~bit;
> +		if (__sync_val_compare_and_swap(w, old, new) == old)
> +			return true;
> +	}
> +	scx_bpf_error("cmask_test_and_clear CAS exhausted at cid %u", cid);
> +	return false;
> +}

Exiting a BPF scheduler when CAS retries fail seems too brutal, while it
is extremely rare to happen. What about adding a kfunc for the slow path
that runs only when the CAS retry fails? For example,
scx_bpf_cmask_test_and_clear( ) does the same thing as
cmask_test_and_clear(), but it never fails. cmask_test_and_clear() calls
scx_bpf_cmask_test_and_clear( ) only when the CAS retry fails. In this
way, we can use the fast path in the BPF implementation while ensuring
the operation succeeds.

> +/**
> + * cmask_next_set - find the first set bit at or after @cid
> + * @m: cmask to search
> + * @cid: starting cid (clamped to @m->base if below)
> + *
> + * Returns the smallest set cid in [@cid, @m->base + @m->nr_bits), or
> + * @m->base + @m->nr_bits if none (the out-of-range sentinel matches the
> + * termination condition used by cmask_for_each()).
> + */
> +static __always_inline u32 cmask_next_set(const struct scx_cmask __arena *m, u32 cid)
> +{
> +	u32 end = m->base + m->nr_bits;
> +	u32 base = m->base / 64;
> +	u32 last_wi = (end - 1) / 64 - base;
> +	u32 start_wi, start_bit, i;
> +
> +	if (cid < m->base)
> +		cid = m->base;
> +	if (cid >= end)
> +		return end;
> +
> +	start_wi = cid / 64 - base;
> +	start_bit = cid & 63;
> +
> +	bpf_for(i, 0, CMASK_MAX_WORDS) {
> +		u32 wi = start_wi + i;
> +		u64 word;
> +		u32 found;
> +
> +		if (wi > last_wi)
> +			break;
> +
> +		word = m->bits[wi];
> +		if (i == 0)
> +			word &= GENMASK_U64(63, start_bit);
> +		if (!word)
> +			continue;
> +
> +		found = (base + wi) * 64 + __builtin_ctzll(word);

Some compiler versions (e.g., clang-18 or older) don’t support
__builtin_ctzll(). To handle this gracefully, there is already a
wrapper, ctzll(), in common.bpf.h. So, I suggest using ctzll()
for compatibility.

Reviewed-by: Changwoo Min <changwoo@igalia.com>
