Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D81A76BB;
	Sat, 25 Apr 2026 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777077600; cv=none; b=Bk2kAsH3LCvLqfaRv4+hnH9Un99ue80ex7ARMUNt+N/Ca7r7x+cvAfOZ1HNWWyKgok6F1Tha6f09yjgmEtEVJ6nsxTdiXAXudTkF51X224+951GL/z/Z/s6nCXldExT5vOuGHakGEGXizTyNoco+QeY4d9I6CUulWyyGAN89v/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777077600; c=relaxed/simple;
	bh=EqpnY65BhGZ0zfN9viNV4FZEEM2WR6bLhXJ7nwuBaTI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=r+0Wg+GgyJJW3i5JyXLv1/fh1BvKNzbFzUixZf2RqNJJrT4YuT8n6P5hMPflwspIJQaIQIlgjI+t31C2SYM1FtJXJszfrQqm6XdEeB3P4Uaws3N+Bq0NdOBrbDvQBSnTfTEkSF6J3IWSJc10IwsZ/+Wii7EcRIdSO6I323kCuPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esRp+Iup; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esRp+Iup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A168C19425;
	Sat, 25 Apr 2026 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777077600;
	bh=EqpnY65BhGZ0zfN9viNV4FZEEM2WR6bLhXJ7nwuBaTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=esRp+IupZXiTXbpQRmOg2aiaOJ8d2qHt57jPP//fJxCrNIGAVGVn99bxlGt/HZVwb
	 iAnybxW7YnAAeBkebrhI8fpet2A8bKHtOOXI6Zh/vx6KedQEsZk03/RHkhFyHt5k2l
	 6bBdwfz6oOud4SZY9fadY1Tt/nxNQbd5brbDdoExvDKnqZ1V0xLOC97yqxhXRGDSll
	 EF0M939YVcF7GNpzw1YthV9U1l8rbWDhrQQ14CK0IU3wI6TxgaCoZVOLiyVdKzhokR
	 hxPsvfW4zZ7mKtY0VXGeW7s+lckKKVqjzUPqL5Tbra5S5w8F6HMPUyhKYAxND8QSzU
	 WC3zmyN8VC/Mg==
Date: Fri, 24 Apr 2026 14:39:59 -1000
Message-ID: <71740a62384f21a1613326a3e450fb69@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Chris Mason <clm@meta.com>,
 Ryan Newton <newton@meta.com>
Subject: Re: [PATCHSET sched_ext/for-7.1-fixes] sched_ext: Assorted fixes
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied 1-13 plus extras 14/13 and 15/13 to sched_ext/for-7.1-fixes.
Patches 13 and 15/13 applied as v2; Andrea's Reviewed-by added on the
other twelve plus 14/13.

Thanks.

--
tejun
