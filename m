Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D732FFF84
	for <sched-ext@lists.linux.dev>; Fri, 12 Dec 2025 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563601; cv=none; b=tQASTmlaihny8WWBQKq3WtvFTeRvZoGgvrCxAxDbTqyv5B3Q10gU/reGvkWIQv4nOd8lP18ive8Sq0XfUsKbBAONXZFOIbMxkkvY9dXePKyT5uIGev9ZjpF/joJzV6ne+RcmVpvTmT+M9H5+X0oGEBEqXrdgR3CEmgtUEY/KVXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563601; c=relaxed/simple;
	bh=D11VZpRhmNiomMaDcpqQBghBTZIUSrMB1joo2gaaf7s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=R/CvAYkiyjZS4uqAvw14fbdvpA7M3g7P8vp5s+/hchgEjgDEOD+JjB4Ci6u8/ybQrIo/hPhpi7YJ4esKYVjCX1idwrW5V9vmCzIkRw8KhPiFsU7Ju0dOn1osp8xMRiVj3ezwcPXAPfPweHW9YpqEwjyx1FdXsTFUoR993zq8C9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcIkv9mu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcIkv9mu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AC9C4CEF1;
	Fri, 12 Dec 2025 18:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765563600;
	bh=D11VZpRhmNiomMaDcpqQBghBTZIUSrMB1joo2gaaf7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VcIkv9muFhRCT8MBE+1OzyZYloz3eFVhSs0K0/1D7IVnUwTTdaRT3LqR0ym1epJiy
	 gV3p9Y2Za8GBB3rEWAkasnew+jrX9xrXKqKe4sx91gbWEkFhyI9VIWS8YTqHoN1oJM
	 w6WplcGYDoQmSkUGFX/32DzPqWm3hO0eXFx8XghtVdXlNeEoE83N0ijFueru61tPyo
	 C+35hltJlJ69NEPKTj4YFV6xUTzG9uA5ElJgfqA7OiM8IlfytHIPK6zRVnqWy3LtVj
	 6w89DI3v5H9PN69rrNQ3OcCyvnI6H+i05cOm5bOhLogh33pkznDw7a7uTQ6gbEliBi
	 vTX9HhOJoaQog==
Date: Fri, 12 Dec 2025 08:19:59 -1000
Message-ID: <c8cbc7765eddda3dd483ecf99f0afce7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Emil Tsalapatis <etsal@meta.com>
Cc: sched-ext@lists.linux.dev, arighi@nvidia.com, changwoo@igalia.com,
 void@manifault.com, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] selftests/sched_ext: flush stdout before test to avoid
 log spam
In-Reply-To: <20251205212314.3553009-1-etsal@meta.com>
References: <20251205212314.3553009-1-etsal@meta.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19-fixes.

Thanks.

--
tejun
