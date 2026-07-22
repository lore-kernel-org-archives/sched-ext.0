Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9923E1D13;
	Wed, 22 Jul 2026 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709302; cv=none; b=es9MnNHeQUNvwLPwUOwhDT6Du59jAavrn70EUUK656xVGwuQT3roCBkAAY49HxbCLXHiCBHrM3hIeks/Y5D9RMZlwRok4q3nsbk1AEjgm8HE1n52p4HcazWInR/LgtmqaYzdkrUrDMEyrQz1csQPQGRYgTKgOUJGProDDszbmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709302; c=relaxed/simple;
	bh=fIWgHamlwkepOfMIvqak6/YTCyX6YiLYdVU7jEynbcA=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=GlU5Ts9YUmXoyvChcBnHbfWf5iDjA85vYr/zMB2clb57ZWWyUicpTEJ9AE/IMHLLy3M92K/zvenjyozvgw7dW9VpS1YHQqp3FJxK2z80FF5uFthB1x9Ze5dcx5Ol/1t6FhfUNz4kUCYyULAjwQgKyL6usUiYw7xHDkPom6ZSYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhSKEIWt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhSKEIWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDEF1F000E9;
	Wed, 22 Jul 2026 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784709300;
	bh=EYaFRV9kAOrrdt/V3gF367+JaznZkDt8PxDhZRvml6A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=RhSKEIWtlipDpnhRuSh3MJzkavHkQVJFqb8lGd3xlnx8e0Kp5bLuU7BG4o+UMBxko
	 ifJTehBASKvYmaig174wNeU/T+LhEOF/27FlPdR00W4YPUcX08H2TPKM+rnknUqRZH
	 M9d95mQt3f7KdA6AU78nP4O454CuUD5miNUZt884z+T426IIp5dNggw3piO6mvhsNg
	 pC6SFbS2/wvpfwkvLYc+JnuDUWt/dPDsGVMeqrY8vkjDeJIhvx0GAoP4dTnMvDX2Ib
	 zmWoenGnL23SjvwFaK0hs1SdTw5khPCKHiGPMzhGBnoVoDg2FXLIEmQb7IlNoRQR84
	 heCVZ5JmKNciQ==
Date: Tue, 21 Jul 2026 22:34:59 -1000
Message-ID: <259253f14b9f38ac9517f1ba28201a26@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
    Andrea Righi <arighi@nvidia.com>,
    Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
    Emil Tsalapatis <emil@etsalapatis.com>,
    linux-kernel@vger.kernel.org
In-Reply-To: <20260721223118.2268529-1-tj@kernel.org>
References: <20260721223118.2268529-1-tj@kernel.org>
Subject: Re: [PATCHSET v2 sched_ext/for-7.3] sched_ext: Sub-scheduler and cid fixes
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Tejun Heo (4):
>   sched_ext: Blame the DSQ's owning scheduler for a runnable stall
>   sched_ext: Skip the default CPU selection while bypassing
>   sched_ext: Drop unused scx_cpumask_to_cmask()
>   sched_ext: Build the cid tables privately and publish them with RCU

Applied 1-4 to sched_ext/for-7.3 with 4 in its v3 form and Andrea's
Reviewed-by added.

Thanks.

--
tejun
