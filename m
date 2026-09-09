Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA30C391829;
	Wed,  9 Sep 2026 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976646; cv=none; b=RtzzamHb4EA7BV/d5KwDH6rATMZJ5EkRpXovZzlR0MJtRONp9fNjT/fHy91VZIhC5KAP3AoS+yK3t7a+5v7Mq5NJd3A4b7IK+1zH5KjFqAIlRj2h9hun6L/Em5DuQEZ6Ktx16awvoakRiptXiL4l57BMzSwd0W6SnpuMLHzv6ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976646; c=relaxed/simple;
	bh=yrCpXGcoydJmpbJVtpIANkua0JB5sKTWmN4rMBY1Ylk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=bhtDsxxxtZpmDbZglO2wxHV7OhRx8LFjgYxYvRQ+z3A1dRy3WuSJQTm50Nhh/hkKXhu7AvC/srT5qcQ8xYfX5qjrm70DElJEd9bW8M3kA2fI2qN2nuDVdeOdN13Ze63CThWS2tVgdktloPZAEj+qo9xFvT13/s0wHnfzfEaSd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esajqce8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esajqce8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7091F000FF;
	Wed,  9 Sep 2026 17:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976645;
	bh=yrCpXGcoydJmpbJVtpIANkua0JB5sKTWmN4rMBY1Ylk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=esajqce88XDkifdpMIELI9vuKTCqQ5N3o42BG8CAQUxmGPMjpfz1YEqBir/FdrUx7
	 EbPT7AMkRa7bXraKS8QNWMk0b8/bhVMBq92wuNkXi3/a3FaqOP9MZ/t2hTWlpdzSON
	 Eguh4k2tg0LFWIigpULc4E+wvY5IX1DhMPDjh7OT9snY4RDxyC+NeJ/ys7fCiQ5Vit
	 6KNFLopPpZKCSZWgL92Xz/mBodthYoQLcpZCZjTJG4ZDmgeQcM+SIL8l42z3Zt3k9P
	 JGN5cXemMzw2z+gDFNw8vonzZGCP3RRjOPDHJIZOCvRyNZ15unqJybCmltVtPp8B2x
	 3+ICHwqD2111g==
Date: Wed, 09 Sep 2026 07:57:24 -1000
Message-ID: <5b44f63388fc7eab10c9b481b1a8096b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tianyi Chen <diannaaav@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] selftests/sched_ext: Validate select_cpu_and
 mask constraints
In-Reply-To:
 <CACGbirTEtYnxiZW0EnOCHbZt66=t-A_Nppp0ChRfM9G2ZD5+aQ@mail.gmail.com>
References:
 <CACGbirTEtYnxiZW0EnOCHbZt66=t-A_Nppp0ChRfM9G2ZD5+aQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Tianyi.

Applied to sched_ext/for-7.4.

Thanks.
--
tejun
