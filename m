Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52203EBF3D;
	Mon,  2 Feb 2026 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061796; cv=none; b=JHDCnTP8O5AIgUsggwIY9bjDpYVh/AgcqhC1qnwkmGn2iegyoxvWO4OTr2L0zjH39JUDxJdH/7oQVNTI4boOwEG8t0yE1LYxsJbPxKSo3WaXrAvs2byN3+txzUwduXfTpee4bDw2PKB0YT/bYcdOXOjljMJXRrGCEdMs4Pb+aOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061796; c=relaxed/simple;
	bh=y0ql+kArP4ZUhWWenXCaYJZ+iapODVlkzugO8Pqh/Bg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qaZ0WgqW3st2CUplgKjrEa0umIupWwuNmL1PcPv+6oCtb2sRv/tKQ3EarE2LtVQ+fW6I6HTJJpunSp6SJuB8ttvflXZvIoRfNSqOg8fUlFx4DKAmgBALMl30tlryreOuR/J9eT3HKYzNfHnnE1YhBQyS0RSLt0Nn27ga8SkcFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJKPQXbS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJKPQXbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D84C116C6;
	Mon,  2 Feb 2026 19:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770061796;
	bh=y0ql+kArP4ZUhWWenXCaYJZ+iapODVlkzugO8Pqh/Bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GJKPQXbSA5e85O88bcneMivsyXHHNWnKy0NrbaokXjn8gdWCe6su8NMp7s/1zxSgj
	 SpsDSV8KSyzyeucv/5DRjkcH9D6NojM/QLY4Tw8ialV4y9jRDk9jWILlcQl2X69o+u
	 8eqEebGCR4MR/vlXsQfm4imyT599cggTgu9pnjsUQN1nc96knERUFWF1J345MF2aFi
	 7eJ/6VcqMssqdAxjIaHSimWuZ+EtrYEVbvfERQW30V2D+uAwAXqmoVn8BQHOTC72xn
	 OD4551Zbr/8Nqcv7HdjOc7EYts+6Y0upUM5TwbUUFsO34G2G0ImIEvO78DeNGHYO3/
	 6ib4Y84Su8e3A==
Date: Mon, 02 Feb 2026 09:49:55 -1000
Message-ID: <380607c7e1d51f2f74b6fbbe066e4f05@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.20] selftests/sched_ext: Fix
 init_enable_count flakiness
In-Reply-To: <03982d7b5642c0ad003668178f9e5df7@kernel.org>
References: <03982d7b5642c0ad003668178f9e5df7@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.20.

Thanks.

--
tejun
