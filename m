Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9114499AB;
	Thu,  9 Jul 2026 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783633224; cv=none; b=qA9WFm3/hFoJ7XA75D0Hje8qzH7VaiNvkqogoHZu4E1CoXwrn+4dUg6CyzgMZ+fVKjOtw4YNxYKpTn+k6IT/lEkTRPFHce69t8fIXw1rSwzsGa3oPAFhdRDYYEUmYeMEz2h4M1RFYJ0e3MUFfbvy2PoL4B7QjNpfE2Jhj/sSDco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783633224; c=relaxed/simple;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=rH//43LkDwru2V0nP6Hu8eE41TwfR3HwX5FgqRlhRHM7/FQQ8WstGDSW65A0AzkAdRS3Br/BYqKSrTwKBPyUgpw65ldAZw/AHMCjlR1S9DVUOF7Ug3XrR5PHQbUuGDsCoIBUfnkaSyj65yI/pZgoBWtgsAbTNr2pNjPha9YRaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETOpXk8g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETOpXk8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6512B1F000E9;
	Thu,  9 Jul 2026 21:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783633222;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ETOpXk8gUj3ns96srleK+MxqhrHpviPQ1I4WbmFPXKxhkv19R7kz02tUXHzcB5UVP
	 hXf2DbuktjjX+uP7b6ngnBtFeEZKx5I1f/Qe1/dIWS5JMu439GnoRIzuw+Ml1GMDn6
	 rtKBSvxsv/4VNBTWiU45i+R6IcyzoEdPZdUpIG8K1BybPpJH89bb+OYmjulqww71IN
	 Ax+92QY3SWAvwddx7DlNGj0NyzsQ42dw3Qlbksl6wsMPRVBHogwBtIzRjUtCBNvL/7
	 U8WNQdqUUilg8Ua8wVflA1oBvxJQhKLY7lwP7NA/N5PQVkuEmyz+kHyHINwNU7JnVt
	 7q6n2mUVP441A==
Date: Thu, 09 Jul 2026 11:40:21 -1000
Message-ID: <dd3d5805c7a0c9398f12e8ab50714144@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Liang Luo <luoliang@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext: Fix typo in scx_bpf_dsq_insert() comment
In-Reply-To: <20260709080205.534892-1-luoliang@kylinos.cn>
References: <20260709080205.534892-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
