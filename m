Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB58B280331
	for <sched-ext@lists.linux.dev>; Wed, 28 Jan 2026 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769565911; cv=none; b=tU1RoZOMEEIahSG977qulJPzoZnmIogt2pks4tonu4YBlrM1tUSCFovA6TI+CCbUrm/ydgwNwoNsF6PUEUuuz9HZ7WXv7bw0cfcyAVivaqOgEl5NoRmpfjMSnGu/SwDSRB4t8YmK2p1jrrCy9BAALfPyLsXybpwk3PurDE8IO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769565911; c=relaxed/simple;
	bh=aJFNRkedcalvKK7q3tAhU1ow/dUzgMTWMxYPRnEVjEk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ezAmca9lSVzlHsrTRebKw3kWUtGd8O8eA6giTOmolcQjT3SRNaAS+Rl2MEiQzfntl95m/fBRu/df4VekGn1bOgDiNL0N/1VcZboBVdvjdzOvkA3/RKfiGlaHSUpsA0rCMQAPhf7nw2KVZJXA2X2EvDjxOKuAicp/tJtC4cZ9x5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7JFqJo7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7JFqJo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984E4C116C6;
	Wed, 28 Jan 2026 02:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769565911;
	bh=aJFNRkedcalvKK7q3tAhU1ow/dUzgMTWMxYPRnEVjEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m7JFqJo7XIOuhySuXVMLcnQdGfk87tJjFhvcf9SSzfYy2/NyvU728BSlq1ikSBYxH
	 0lS+jTgn0qcWyYLIGOpszRrtWHNm0kquNfaHXM9wGUi/HUTE5TbELBvX3497rEW1+6
	 b3r88rVd/dKuiRlJ7xAJJZrWkLK2rxj48+sergqjHATehysr93rnoG6/JuJ6IZtvRw
	 0JQaDzzFWjhtIsJi1EElSUuq7EETh2rfs/I8tG1zAiNx+KlcvKnAdV3sKnaLYXFWNP
	 w0yWDp0xLDhF5sUuudkwKfieH28IiLhfoFpSfwt6x/VEzCEYDmfz2CU5EXTP+T9ZCj
	 PRJXMc7lm/Xvg==
Date: Tue, 27 Jan 2026 16:05:10 -1000
Message-ID: <a16cc5a7a8f6db10763e0347a0f3759a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: sched-ext@lists.linux.dev, changwoo@igalia.com,
 arighi@nvidia.com, void@manifault.com
Subject: Re: [PATCH v3 3/3] tools/sched_ext: add arena based scheduler
In-Reply-To: <20260123032605.49140-4-emil@etsalapatis.com>
References: <20260123032605.49140-1-emil@etsalapatis.com>
 <20260123032605.49140-4-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

[This is a AI generated review by Claude Opus 4.5]

> +	pos = idx & mask;
> +	data = chunk->data[pos];
> +	if (likely(data)) {
> +		data[pos] = (struct sdt_data) {
> +			.tid.genn = data->tid.genn + 1,
> +		};

data already points to chunk->data[pos], so data[pos] double-indexes and
writes to the wrong memory location. This should be *data. The payload
zeroing loop below correctly uses data->payload[i], so this is just the
struct assignment that's off.

Please send a fix.
