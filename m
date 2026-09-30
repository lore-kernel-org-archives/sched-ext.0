Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C75218A2;
	Wed, 30 Sep 2026 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791283; cv=none; b=JuFvoNOPhGWzi6ZyilBdg/uEKqPg1OHqDTvL5wr9RHIAplV/YuZbum17mSmEkQIL19/BV7woOnB/RrNCK3+MFbnYkvsV4+aBA3E0w7jav47tNFsUw4CaHdDRGGctAvn2Gh2YBlgaub8ZYw5HURiFZzDetQSBWvTUpSDWOc20ews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791283; c=relaxed/simple;
	bh=a3IQVp4KV6A2P8dLA/3YE3YJLIUkgcjm08atMciwBzA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=tzrFklIzCmCTe/ctTJBZjIJx9Tdv9eluQqady9Ej6ok+e9sdDkcRoVDvPvTEFgPA4Cku6A2PSi3Dcl0kP6lop9Fyq1jh/aYoGtnSBS7oayvH0CPBBfqMvbxS6e8Jz3bRnKPzN7oQbOS7vRVtsiRfr71+BPdVimB0Uvwe9TcpVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chud/kGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chud/kGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460DE1F00898;
	Wed, 30 Sep 2026 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791282;
	bh=a3IQVp4KV6A2P8dLA/3YE3YJLIUkgcjm08atMciwBzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=chud/kGobc994tEDDJMc/Mak6fsR/KpCifJagoQx+Jr0fnwmGmvlfT5X+pjzMAHyE
	 37d3sHXqQiSigee8ih4+d+yo+Z1feruW/4QLrwQVfjaVneaWfqI4QlbbEpkKGdr6l+
	 /e9yAu0zlITfWkSSPwYwPGfjKdXEpYrA6l8Saa0Mpy0a3k//7Jc6el28kY7e+ZqPS+
	 dVGBAe6Q6812Z5lj5T0qDaHOykWEhOlMzsE8F4No/N3lP0w9JM+QxUOUs28mfGlRsP
	 2s0aX+8nisLZ5wWdf2EVmGJRtS7vnhAaGxP2MDU7nL4bO50UMOBXRuLIT5I29Ex65n
	 wYKz6SJI6eBmw==
Date: Wed, 30 Sep 2026 08:01:21 -1000
Message-ID: <b595d8eb3a1a279a7863bbd2d0cfdee7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v3 sched_ext/for-7.3-fixes] sched_ext: Fix missing
 ops.dequeue() on remote local DSQ moves
In-Reply-To: <20260930142412.552765-1-jpiecuch@google.com>
References: <20260930142412.552765-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied 1-2 to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
