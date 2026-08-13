Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941E34D38B;
	Thu, 13 Aug 2026 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641142; cv=none; b=J8KQz3UQin+9//rLwy3QmOooznnR+7MPOCerdDTPs1sXrzIvcTONLLaX3TmwhGJo7X5BlFhtLwq6u72kQESmQNs2osbFQ8b7Wu3twSUaFsfJSu127v3hTxCkp4zQPB7BpdFtKXwhPK4VOT8lcffWCDf4FGkW4oT7dS7olFDm2Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641142; c=relaxed/simple;
	bh=amRNeLvzi7DJ+R2Zk5ORBJZGvuajpFE61ZAD0kSIJ0w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=esZRmL9Fq2lgrX+IK2BCVtc7LOt9imssoDzuFHx3IR2kxf9Q9Igl9AQ3YmFRGl4F5wCh9QLqgfp4zxIbc2ZNWgsJ0bUO+twhVw+VL30BT7t7x7tC8c7c2a4EKyLr/1DU2pzO63C27DN2ze6+E+uCH00ZuEOaJ98RwC25WQ6JC38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAMJuTHh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAMJuTHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D091F000E9;
	Thu, 13 Aug 2026 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641140;
	bh=amRNeLvzi7DJ+R2Zk5ORBJZGvuajpFE61ZAD0kSIJ0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LAMJuTHh+wuhGffysXOGe9E/aB2waXQIV9snHshQeXfHwBBhR4tBdsqtOn4qksRCc
	 3oqFnPG1TLl/kE8aoKFM3o3+uSkkWs5pjAWm3Ch/qZfv0JfVNLK+vHn4E2gjCH6iQW
	 EYtHsaag5bRgaIK+3ryo47xTSxPOm0XmheGNxuTguOIwe2QUGiWJWLFRBu7Et4yIgS
	 FT75PGPd0ixCh5PEMgvLXkruwnF0NaYDQsjBH2aEvl3MNbvPmpMSc8pNwheXzwHnxh
	 DD+Y3QFI6ry/XOhbCHgcZddFSqNMOm60n+DY+d1tUyucxa4B8I7Wbs+ixwojGkrNeX
	 Iz+aMnYL6H4hw==
Date: Thu, 13 Aug 2026 07:12:20 -1000
Message-ID: <c7abeaf94f09d45703fd91d1dbb440d4@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3-arena-args] sched_ext: Convert
 arena-pointer interfaces to __arena arguments
In-Reply-To: <20260812211609.2495583-1-tj@kernel.org>
References: <20260812211609.2495583-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied 1-3 to sched_ext/for-7.3-arena-args.

Thanks.

--
tejun
