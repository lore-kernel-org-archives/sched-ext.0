Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F72386C1B;
	Tue,  3 Mar 2026 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772525210; cv=none; b=V3LBbjLi30Ci2aQfsgjBmyl0hslTS3713Tiyl0g8ovcU24CIfXKvDegySH7DW1iScJhsNSunU39o4+qdjzFq0vgjUBz4fr4vOJ35mtfwSx/k8pqo/IKecWw0jP6Tgl/kfQStUEusVaAlqmTwRF05kXrlqygiFssX7ladn0G8DAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772525210; c=relaxed/simple;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=MgmyLa0cveAFkt9yFkL9nR5tRAdCbUxS1X3BJgJoF3GF6z684qRVUObu+lQ7KnFf86Kc1r/smphC26hGOo7u9NGP5FMx8C4xvRgGt1NHzkZ4/JkN3/YxU7SSQULXl0p18quka7V81L7rRwr2luXW4rRi1iE2VHvz0MNeD2/E9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg9ReHh8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg9ReHh8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B91C116C6;
	Tue,  3 Mar 2026 08:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772525210;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vg9ReHh86gAfq+klzBsxjAg7bVOpbjwG5Ffol/WyCFkGjyMYrTqMV56TMVKrTpuYN
	 j7utdJ6tjNpv80vkeTYOAKINJv1pZv9AOKlUtGfU9Zfw8a1sWmYElgam1ZIUuor3Qb
	 NJ/R8Tegl1xRKvXqn/97joNuh+NfXQCEanu8UZpAoRKqj4ZTBAdTXveTJulStgSZ+e
	 vUBs+uXjpIqDeKBdoSSBSyZPpH+rfqkVDsT91ci5N3gTyOK4mcASr+LLzXzG/Ke1B7
	 rAyENIhuk/c8eDRgAAGE7VbHDTWGpBZFctjx3+DpVLfppE9U085oewWB+alExQviXH
	 yIsa2krMw8uKg==
Date: Mon, 02 Mar 2026 22:06:47 -1000
Message-ID: <e62dd02f758360b996b5c5ea379d23f0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: zhidao su <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 peterz@infradead.org,
 mingo@redhat.com,
 zhidao su <suzhidao@xiaomi.com>
Subject: Re: [PATCH] sched_ext: Use READ_ONCE() for plain reads of
 scx_watchdog_timeout
In-Reply-To: <20260303060958.120517-1-suzhidao@xiaomi.com>
References: <20260303060958.120517-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
