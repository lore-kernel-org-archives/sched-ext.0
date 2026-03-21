Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8933D6D3;
	Sat, 21 Mar 2026 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774118563; cv=none; b=aTJlve5sqDjB+wyOV1EgQxgY6URd2QvXpL4a15sqxFhJuMAzJ7rqvS+gC8ZY0M+EaN7IHhOsr4pWilI+ZudqZXa/SWijrlzMZlm0k0XjjyrvM9MhyGT8xD9D9CWGa6mVbppp8D73Mc2XB1q/YcJ9eBUb2fFqlSq++x55SAOukEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774118563; c=relaxed/simple;
	bh=FVItYG3lML5faQW3QnZHLXrWvMdEshlCWbubfl053ZI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=R1qe6zC8tLN+ub9xP4gaAS6HXD4kyJiX/aFfN4z5Bt17IjY5PTPYdvMcuQ4pfJwoOti/8VoLpD6KAuoSPAtHzo97tFG+g23/EIp6hA8DggLfH0HhWRyTpj5rqYOS6hxs3pOPlDzqpJCQCAmI4U3HzrtqGIqRfPimreIesvA9rLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVTFQ2i6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVTFQ2i6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4E5C19421;
	Sat, 21 Mar 2026 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774118562;
	bh=FVItYG3lML5faQW3QnZHLXrWvMdEshlCWbubfl053ZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aVTFQ2i6KArn7tEaSj/bN4s7x446IVsDJEe5lPAgDrei/XW68tzuTFk5qUM251AV9
	 AIEHuX8tUnjud/PxlYbfwwc2XugH2c1iIn1ogmsrXo0AWhxphCjPjJP4X9UF5uAc7e
	 ymoc1zaqkm+GVD41QSRerEmvVyXRSE1M/HjkfylbQOI03Ex0TResnR40ZrqxA+6Z2s
	 3hMRd0EmPywaDPvmFbJJR1WGovu40E11udh1cB/yX4oHgMicicbHfMEaWruiqx+Lcd
	 q2WZKv2rHH62asOTT2fLR3f50mCXCoNrSacoNc68M9hCTSo4YmermwuF3NHD+fibWL
	 Cwy6Z53h3R07g==
Date: Sat, 21 Mar 2026 08:42:41 -1000
Message-ID: <fd4f7ef33aa066479ae7d1ce176b6e48@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: zhidao su <suzhidao@xiaomi.com>,
 sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH 1/2] sched_ext: Documentation: Document events sysfs
 file and module parameters
In-Reply-To: <20260319053026.447892-1-suzhidao@xiaomi.com>
References: <20260319053026.447892-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied 1-2 to sched_ext/for-7.1 with the following modification
to 1/2:

  Fixed SCX_EV_INSERT_NOT_OWNED description - the check is whether
  the task (not the DSQ) is owned by the scheduler.

Thanks.

--
tejun
